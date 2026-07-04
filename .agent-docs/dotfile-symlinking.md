# Dotfile symlinking pipeline

Dotfiles are managed by a custom pipeline declared in [home-manager/dotfile-symlinking/](../home-manager/dotfile-symlinking/). The pipeline converts source files in `src/` into `home.file` entries that Home Manager symlinks into place.

## How it works

[dotfile-symlinking.nix](../home-manager/modules/core/dotfile-symlinking.nix) drives the pipeline:

1. It reads every `.nix` file under `pipeline/` and imports each one with shared args.
2. The pipeline stages are merged and run through `sundry.attrs.resolve-deps` — a dependency-aware evaluator that runs stages in the correct order.
3. The final `result` key is passed to `home.file`.

## Pipeline stages

| Stage | File | What it does |
|---|---|---|
| `imports` | [pipeline/imports.nix](../home-manager/dotfile-symlinking/pipeline/imports.nix) | Reads all files from `src/`, resolves tags, rewrites paths using `{place:…}` tags |
| `processed-imports` | same file | Filters out `{x}`, `{include}`, `{build}`, `{convert}` tagged files |
| `nix-imports` | [pipeline/nix.nix](../home-manager/dotfile-symlinking/pipeline/nix.nix) | Imports every `.nix` file, evaluating it with `{ lib, pkgs, file-dir }` |
| `nix` | same file | Converts `{convert:json}` / `{convert:ini}` files to text using `lib.generators` |
| `sass-staging-dir` | [pipeline/sass.nix](../home-manager/dotfile-symlinking/pipeline/sass.nix) | Materialises `.scss` files into a Nix derivation directory |
| `sass-load-paths` | same file | Collects `{include:sass}` dirs as `--load-path` flags for the Sass compiler |
| `sass` | same file | Compiles `{build:sass}` `.scss` files to `.css` via `dart-sass` |
| `result` | [pipeline/result.nix](../home-manager/dotfile-symlinking/pipeline/result.nix) | Merges all stages; applies `{ext:…}` renames; collapses to `home.file` attrset |

## Tag syntax in file/directory names

Tags are embedded in path segments as `{key}` or `{key:value}`. Multiple values for a single key are comma-separated: `{key:v1,v2}`. The `sundry.vfs` library parses and resolves them — see `~/sundry/.agent-docs/data-model.md` and `tag-matching.md` for the full model.

| Tag | Where | Meaning |
|---|---|---|
| `{place:segment\|nested}` | directory | Replaces this path segment with the given destination path. `\|` splits the value into sub-segments (local convention in `imports.nix`, not part of sundry's tag syntax). |
| `{convert:json}` / `{convert:ini}` | file | `.nix` file evaluates to an attrset; pipeline serialises it to JSON or INI text. |
| `{ext:ext}` | file | Overrides the output file extension in the final symlink path. |
| `{build:sass}` | file | This `.scss` file is a Sass entry point — compile it to `.css`. |
| `{include:sass}` | directory | This directory is a Sass include path. The `--load-path` passed to Sass is the directory **one level above** the tagged segment (i.e. `lib.take tag-pos path` inside the staging derivation). |
| `{x}` | file or dir | Excluded from output; used for source-only helpers (e.g. `settings-parts{x}/`). |
| `{hosts:name}` | file or dir | Only included when building for the named host. |

## Example: VS Code settings

```
src/vscode{place:.config|Code|User}/
  settings{convert:json}.nix          → ~/.config/Code/User/settings.json
  keybindings{convert:json}.nix       → ~/.config/Code/User/keybindings.json
  settings-parts{x}/                  → excluded; imported by settings.nix
```

`settings.nix` imports files from `settings-parts{x}/` manually using `file-dir`. The `{x}` tag keeps those parts out of the top-level output.

## Adding a new dotfile

1. Create the source file under `src/` with the appropriate `{place:…}` tag on its containing directory.
2. If the file is a Nix expression that should be serialised, add `{convert:json}` or `{convert:ini}` to the filename.
3. If it's a `.scss` entry point, tag it `{build:sass}`; tag include-only directories `{include:sass}`.
4. Run `nixos-rebuild switch` to apply.
