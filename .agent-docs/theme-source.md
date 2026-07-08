# Единый источник темы (TODO — не реализовано)

Дизайн-решение для единого источника правды по внешнему виду рабочего стола
(радиус скругления, отступы, цвета, шрифты). **Пока не реализовано** — это план.
Текущее состояние: значения захардкожены по всему дереву вручную, список мест —
в [HARDCODED-VALUES.txt](HARDCODED-VALUES.txt).

## Предыстория

Раньше существовала локальная `lib/style/*` (`config.style.palette`,
`config.style.constants`, `config.style.font`) и шаг подстановки `#[...]` через
`substitute-expressions`. При миграции на новый dotfile-пайплайн эта система была
снесена: `lib/` удалён целиком, а значения захардкожены как локальные `let`-биндинги
в каждом файле (см. [HARDCODED-VALUES.txt](HARDCODED-VALUES.txt), части 2–3).

Возвращать `#[...]`-шаблонизатор **не нужно**: он был отдельным compile-шагом над
текстом файлов. Ниже — способ без него.

## Ключевое различие: подстановка в текст ≠ IFD

IFD — это только когда результат сборки *деривации* читается обратно в Nix-оценку
(как `builtins.readFile (pkgs.runCommand …)` в
[waybar config.nix](../src/desktop-environment/user%7Bmodules:user%7D/applications/waybar/config%7Bdotfiles:.config%7Cwaybar%7D/config%7Bconvert:json%7D%7Bext:jsonc%7D.nix)
для `nproc`). Обычная интерполяция `"radius: ${theme.radius}"` — **не IFD**: ноль
деривации. Поэтому единый источник темы не обязан быть IFD и не должен им быть.

Компиляция sass в [sass.nix](../infrastructure/dotfile-symlinking%7Bmodules:user%7D/pipeline%7Bparts%7D/sass.nix)
— тоже не IFD: результат идёт прямо в `home.file`, обратно в оценку не читается.

## Где живёт: `infrastructure/`, не домен

Тему инжестят **несколько доменов** — `applications/` (vscode, alacritty) и
`desktop-environment/` (waybar, wofi, hyprland). Значит она не принадлежит ни одному
`src/`-домену: назначить один домен-потребитель владельцем общего ресурса неверно.
Она наддоменная и сидит **над** доменами — в `infrastructure/`.

`infrastructure/` — это «фундамент для модулей, но сам не модуль» (шире, чем «build
machinery»): туда входит и пайплайн (механизм, что *бежит*), и тема (данные, что
*читаются*). Разные роды, одна ось. См. [structure.md](structure.md).

Файл: `infrastructure/theme{parts}.nix` (или каталог `theme{parts}/`, если тема
разрастётся на palette/constants/font, как было в снесённом `lib/style/`). Тег
`{parts}` — чтобы module-discovery её не подхватил: это **данные, читаемые через
special arg**, а не модуль.

**Ссылаться на файл из [flake.nix](../flake.nix) строкой под `config-root`**
(`"${config-root}/infrastructure/theme{parts}.nix"`), не path-литералом — `{` в имени
сломал бы имя нового store-объекта (см. [gotchas.md](gotchas.md)).

## Источник правды: один Nix-атрибутсет

`infrastructure/theme{parts}.nix` — плоский attrset:

```nix
{
  radius = 12;
  offset = 6;
  font.family = "JetBrainsMono Nerd Font";
  palette = { black = "#1d1f21"; accent = "#7aa6da"; /* … */ };
}
```

Прокидывается в `module-args` в [flake.nix](../flake.nix) (рядом с `username`/`host`,
строка ~65). Тогда он разом попадает и в `specialArgs` (NixOS-модули), и в
`extraSpecialArgs` (Home Manager). Отдельно — прокинуть в args пайплайна в
[pipeline{parts}/nix.nix](../infrastructure/dotfile-symlinking%7Bmodules:user%7D/pipeline%7Bparts%7D/nix.nix),
где `.nix`-дотфайлы импортируются в `expr`.

**Канал `host`→дотфайлы уже открыт.** При выносе `nproc` из IFD в
[waybar config.nix](../src/desktop-environment/user%7Bmodules:user%7D/applications/waybar/config%7Bdotfiles:.config%7Cwaybar%7D/config%7Bconvert:json%7D%7Bext:jsonc%7D.nix)
в [nix.nix](../infrastructure/dotfile-symlinking%7Bmodules:user%7D/pipeline%7Bparts%7D/nix.nix)
уже добавлен `host` в args импорта дотфайла (был только `{lib, pkgs, file-dir}`).
`theme` добавляется туда же **одной строкой** — `inherit lib pkgs host theme;` — и
прокидывается из entrypoint так же, как `host` (entrypoint — HM-модуль, все
`module-args`/special args уже в его `args`; надо лишь довести `theme` до
`module-args` во [flake.nix](../flake.nix)).

## Прокидывание — свой механизм на каждый класс формата

Универсальный шаблонизатор со своим синтаксисом — худший вариант (тащит compile-шаг,
ломает валидность исходников, дублирует то, что язык уже умеет). Вместо этого:

| Формат | Механизм | IFD? |
|---|---|---|
| `.nix`-модули (hyprland-опции, gtk) | special arg `theme` напрямую | нет |
| `{convert:json}` / `{convert:ini}` (waybar, vscode) | это уже Nix-выражения — просто ссылайся на `theme` | нет |
| bash/conf с простыми значениями | env-переменные из `theme` | нет |
| **scss** | Nix генерит партиал `_theme` с `$radius: 12px;`, рукописный scss делает `@use "theme"` | нет |
| **lua** (будущий hyprland) | Nix генерит `theme.lua` (возвращает таблицу), рукописный код `require` его | нет |

### Приём для scss и lua: генерируемый партиал, а не предобработка файла

Не предобрабатывать существующий scss/lua своим синтаксисом. Вместо этого генерировать
**маленький сгенерированный файл-партиал** из Nix, а рукописный код импортирует его
штатным механизмом языка (`@use`, `require`):

- scss: `theme.nix` → партиал в `{include:sass}`-директории (`$radius: 12px;` …),
  рукописные `.scss` делают `@use "theme";`. Sass-часть пайплайна уже есть.
- lua: `theme.lua` возвращает таблицу, hyprland-lua её `require`.

Плюсы: ни своего шаблонизатора, ни IFD, рукописный код остаётся валидным для IDE/линтера,
пайплайн это почти умеет (`{convert}` = «Nix-выражение → текстовый файл»).

## TODO при реализации

1. Создать `infrastructure/theme{parts}.nix` (значения — из [HARDCODED-VALUES.txt](HARDCODED-VALUES.txt),
   бывшие `lib/style/palette.nix`, `constants.nix`, `font.nix`).
2. Добавить `theme` в `module-args` в [flake.nix](../flake.nix) — читая файл строкой под
   `config-root` (`"${config-root}/infrastructure/theme{parts}.nix"`), не path-литералом
   (см. [gotchas.md](gotchas.md)) — и добавить `theme` в args импорта дотфайла в
   [pipeline{parts}/nix.nix](../infrastructure/dotfile-symlinking%7Bmodules:user%7D/pipeline%7Bparts%7D/nix.nix)
   (`host` там уже проброшен).
3. Отменить хардкод по местам из [HARDCODED-VALUES.txt](HARDCODED-VALUES.txt) (пункты 1–9),
   заменив локальные `let`-блоки на `theme.*`. Пункт 8 (nproc) уже решён отдельно через
   `host.cores` — тема его не трогает.
4. Для scss завести генерируемый `_theme`-партиал; заменить `@use` в рукописных стилях.
5. Когда всё переведено — удалить [HARDCODED-VALUES.txt](HARDCODED-VALUES.txt) и этот файл
   заменить на описание *действующей* системы (или влить в
   [dotfile-symlinking.md](dotfile-symlinking.md)).
