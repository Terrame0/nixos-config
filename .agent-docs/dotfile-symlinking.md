# Dotfile symlinking pipeline

Dotfiles are produced by a custom pipeline under [home-manager/modules/core/dotfile-symlinking/](../home-manager/modules/core/dotfile-symlinking/). It turns tagged source files into `home.file` entries that Home Manager symlinks into place. Sources are dotfiles tagged inline in the module tree — a dotfile lives in the same folder as the module it belongs to.

## How it works

[entrypoint.nix](../home-manager/modules/core/dotfile-symlinking/entrypoint.nix) drives it:

1. It reads every `.nix` file under `pipeline{x}/` and imports each with shared args.
2. The stages are merged and run through `sundry.attrs.resolve-deps` — a dependency-aware evaluator that orders stages by their declared `deps`.
3. The final `result` key is assigned to `home.file`.

The pipeline directory is tagged `{x}` so its own files are never mistaken for dotfile sources or NixOS/HM modules.

## Source: the inline module tree

`imports` reads one root ([imports.nix](../home-manager/modules/core/dotfile-symlinking/pipeline%7Bx%7D/imports.nix)):

| Root | Selection | Destination path comes from |
|---|---|---|
| `home-manager/modules/` | only subtrees tagged `{dotfiles:…}` | the `{dotfiles:PATH}` tag value |

The module tree also holds real NixOS/HM modules, so a dotfile there **must** carry `{dotfiles:PATH}` both to opt in and to state where it lands. This lets a feature keep its module and its dotfiles side by side (e.g. `waybar/package.nix` next to `waybar/config{dotfiles:.config|waybar}/`).

The `{dotfiles}` selection is the mirror of `filter-modules` in [flake.nix](../flake.nix): module discovery *excludes* `{dotfiles}` subtrees, dotfile discovery *includes* only them — the two never claim the same file.

## Tag model: nouns classify, verbs process

The tag vocabulary splits along one axis:

- **Nouns — ingest class** (mutually exclusive): `{dotfiles:PATH}` today; `{modules:system}` / `{modules:home}` planned, to replace the positional `system/modules` vs `home-manager/modules` split the way `{hosts:…}` already replaced host directories. A file belongs to exactly one class.
- **Verbs — processing within a class**: `{convert:json}`, `{build:sass}`. Only meaningful inside `{dotfiles}` — a `.nix` module ingests as-is, so it carries no verbs.

`{build:sass}` and `{convert:json}` stay distinct even though both target dotfiles: `convert` is a pure per-file serialisation (attrset → text), `build` is a compile that pulls `{include:sass}` load-paths and can fail — different operations, not two spellings of one.

## Pipeline stages

| Stage | File | What it does |
|---|---|---|
| `imports` | [imports.nix](../home-manager/modules/core/dotfile-symlinking/pipeline%7Bx%7D/imports.nix) | Scans the module tree, resolves tags, selects `{dotfiles}` subtrees. **Paths stay as-is** — no home-relative rewrite here. |
| `processed-imports` | same file | Drops `{include}`, `{build}`, `{convert}`, `{x}` files — the raw-copy set. |
| `nix-imports` | [nix.nix](../home-manager/modules/core/dotfile-symlinking/pipeline%7Bx%7D/nix.nix) | Imports every `.nix`, evaluating it with `{ lib, pkgs, file-dir }` into `.expr`. |
| `nix` | same file | Serialises `{convert:json}` / `{convert:ini}` files' `.expr` to text via `lib.generators`. |
| `sass-staging-dir` | [sass.nix](../home-manager/modules/core/dotfile-symlinking/pipeline%7Bx%7D/sass.nix) | Materialises all `.scss` into one derivation directory. |
| `sass-load-paths` | same file | Collects `{include:sass}` dirs as `--load-path` flags. |
| `sass` | same file | Compiles `{build:sass}` entry points to `.css` via `dart-sass`. |
| `result` | [result.nix](../home-manager/modules/core/dotfile-symlinking/pipeline%7Bx%7D/result.nix) | Merges all stages; applies `{ext:…}` renames; **rewrites each path to its `~`-relative home path** (`to-home-path`); collapses to `home.file`. |

### Where the home-relative rewrite happens — and why it's last

`{dotfiles:PATH}` gives a path **relative to `~`**, replacing everything to its left. `PATH` uses `|` to separate segments (local convention, not sundry tag syntax): `{dotfiles:.config|waybar}` → `~/.config/waybar/`.

This rewrite lives in `result`'s `to-home-path`, applied only when building the `home.file` key — **not** in `imports`. The VFS node's `path` stays in its original (source-tree) coordinates through every stage. This is deliberate: `sass-load-paths` computes `lib.take tag-pos path`, which relies on `tag-pos` (an index into the node's `tag-list`) still indexing `path`. Rewriting `path` early — but not `tag-list` — desynchronises the two, and `take` overshoots into file paths instead of include dirs. See [gotchas.md](gotchas.md).

## Tag syntax in file/directory names

Tags are embedded in path segments as `{key}` or `{key:value}`; multiple values are comma-separated (`{key:v1,v2}`). `sundry.vfs` parses them — see `~/sundry/.agent-docs/data-model.md` and `tag-matching.md`.

| Tag | Where | Meaning |
|---|---|---|
| `{dotfiles:seg\|nested}` | directory | Marks the subtree as a dotfile source and sets its `~`-relative destination. `\|` splits sub-segments. |
| `{convert:json}` / `{convert:ini}` | file | `.nix` evaluates to an attrset; pipeline serialises it to JSON / INI text. |
| `{ext:ext}` | file | Overrides the output extension. Bare `{ext}` strips the extension entirely. |
| `{build:sass}` | file | This `.scss` is a Sass entry point — compile to `.css`. |
| `{include:sass}` | directory | Sass include path. The `--load-path` is the dir **above** the tagged segment (`lib.take tag-pos path` in the staging derivation). |
| `{x}` | file or dir | Excluded from output; source-only helpers (e.g. `settings-parts{x}/`, the `pipeline{x}/` dir itself). |
| `{hosts:name}` | file or dir | Only built for the named host. |

## Example: VS Code settings

```
modules/applications/vscode/
  program.nix                                       → HM module (installs vscode)
  extensions.nix                                    → HM module
  config{dotfiles:.config|Code|User}/
    settings{convert:json}.nix                      → ~/.config/Code/User/settings.json
    keybindings{convert:json}.nix                   → ~/.config/Code/User/keybindings.json
    settings-parts{x}/                              → excluded; imported by settings.nix via file-dir
```

`{dotfiles:.config|Code|User}` pins the destination. `settings.nix` imports the `{x}`-tagged parts manually with `file-dir`; `{x}` keeps them out of the output.

## Example: waybar

```
modules/desktop-environment/applications/waybar/
  package.nix                                     → HM module (installs waybar)
  config{dotfiles:.config|waybar}/
    config{convert:json}{ext:jsonc}.nix           → ~/.config/waybar/config.jsonc
    style{build:sass}.scss                        → ~/.config/waybar/style.css
    waybar{include:sass}/                          → Sass load-path, not emitted
```

The module and its dotfiles live together. `{dotfiles:.config|waybar}` opts the subtree into the dotfile pipeline and pins its destination; the module `package.nix` beside it is picked up by `filter-modules`, not the dotfile pipeline.

## Adding a new dotfile

1. Put it under `home-manager/modules/…/`, next to the module it belongs to, and tag the containing directory `{dotfiles:PATH}` with the `|`-separated home path.
2. If it's a Nix expression to serialise, add `{convert:json}` or `{convert:ini}` to the filename.
3. If it's a `.scss` entry point, tag it `{build:sass}`; tag include-only dirs `{include:sass}`.
4. `git add` the new file (a flake only sees git-tracked files) and `nixos-rebuild switch`.
