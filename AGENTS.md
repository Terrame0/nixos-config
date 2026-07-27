# AGENTS.md

NixOS + Home Manager configuration for three hosts (`desktop`, `laptop`, `lenovo`). Declared as a Nix flake; Home Manager runs as a NixOS module, so everything is applied through the system rebuild flow. The repo depends on the private `sundry` library for VFS and attribute utilities.

## Before working, read the relevant doc in `.agent-docs/`

Codex loads this file automatically. The topic docs below are not auto-imported by Codex, so read the relevant files before making changes.

- [structure.md](.agent-docs/structure.md) — overall repo layout, multi-host setup, special args, flake inputs.
- [dotfile-symlinking.md](.agent-docs/dotfile-symlinking.md) — how dotfiles are managed: pipeline stages, tag syntax, adding new dotfiles.
- [sing-box.md](.agent-docs/sing-box.md) — VPN proxy service: subscription updater, config skeleton, secrets.
- [secrets.md](.agent-docs/secrets.md) — sops-nix: how secrets are auto-derived from the `secrets/*.yaml` files, the age key, and `LoadCredential`.
- [gotchas.md](.agent-docs/gotchas.md) — counter-intuitive traps: nix eval vs build, flake git-tracking, empty sing-box selectors, and more.
- [theme-source.md](.agent-docs/theme-source.md) — **TODO/план:** единый источник темы (радиус, цвета, шрифты) в `infrastructure/theme{parts}.nix` + прокидывание по классам форматов. Ещё не реализовано.
- [HARDCODED-VALUES.txt](.agent-docs/HARDCODED-VALUES.txt) — список мест, где значения стиля захардкожены вручную после сноса `lib/style` — что отменить при возврате единого источника ([theme-source.md](.agent-docs/theme-source.md)).

When you add, rename, or remove a doc under `.agent-docs/`, update this index in the same change so it does not drift from what's on disk.
