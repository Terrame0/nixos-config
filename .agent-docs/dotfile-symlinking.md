# Dotfile symlinking pipeline

Dotfiles are produced by a custom pipeline under [src/dotfile-symlinking{modules:user}/](../src/dotfile-symlinking%7Bmodules:user%7D/). It turns tagged source files into `home.file` entries that Home Manager symlinks into place. Sources are dotfiles tagged inline in the module tree — a dotfile lives in the same folder as the module it belongs to.

## How it works

[default.nix](../src/dotfile-symlinking%7Bmodules:user%7D/default.nix) drives it:

1. It collapses `root-vfs.src.dotfile-symlinking.pipeline` and evaluates each stage file as `file.expr args`, using the `expr` the global `load-nix` already attached.
2. The stages are merged and run through `sundry.attrs.resolve-deps` — a dependency-aware evaluator that orders stages by their declared `deps`.
3. The final `home-files` key is assigned to `home.file`.

The pipeline no longer touches the `root` path — it starts from the `root-vfs.src.dotfile-symlinking.pipeline` subtree, where `.expr` is already present. The pipeline directory is tagged `{private}` so its own files are never mistaken for dotfile sources or modules.

## Source: the module tree

`dotfile-sources` selects only the `{dotfiles:…}` subtrees from `root-vfs`, the repo's already-resolved VFS tree ([imports.nix](../src/dotfile-symlinking%7Bmodules:user%7D/pipeline%7Bprivate%7D/imports.nix)):

| Root | Selection | Destination path comes from |
|---|---|---|
| `root-vfs` (whole repo) | only subtrees tagged `{dotfiles:…}` | the `{dotfiles:PATH}` tag value |

`root-vfs` already contains the design-system partials: [`meta/system-assembly/each-host.nix`](../meta/system-assembly/each-host.nix) merges `design-system.partials-vfs` (tagged `{dotfiles:.design-system}`) into the tree before any pipeline stage runs, so `dotfile-sources` sees them as ordinary `{dotfiles}` subtrees. Tag resolution happens when `root-vfs` is built, not in the pipeline.

The tree also holds real modules, so a dotfile there **must** carry `{dotfiles:PATH}` both to opt in and to state where it lands. This lets a feature keep its module and its dotfiles side by side (e.g. `waybar/package.nix` next to `waybar/config{dotfiles:.config|waybar}/`).

The `{dotfiles}` selection is the mirror of module discovery in [flake.nix](../flake.nix): discovery *excludes* `{dotfiles}` subtrees, dotfile discovery *includes* only them — the two never claim the same file.

## Tag model: nouns classify, verbs process

The tag vocabulary splits along one axis:

- **Nouns — ingest class** (mutually exclusive): `{modules:system}` / `{modules:user}` for a module and its level, `{dotfiles:PATH}` for a dotfile. A file belongs to exactly one class — a module or a dotfile, never both.
- **Verbs — processing within a class**: `{convert:json}`, `{build:sass}`. Only meaningful inside `{dotfiles}` — a `.nix` module ingests as-is, so it carries no verbs.

`{build:sass}` and `{convert:json}` stay distinct even though both target dotfiles: `convert` is a pure per-file serialisation (attrset → text), `build` is a compile that pulls `{include:sass}` load-paths and can fail — different operations, not two spellings of one.

## Pipeline stages

| Stage | File | What it does |
|---|---|---|
| `dotfile-sources` | [imports.nix](../src/dotfile-symlinking%7Bmodules:user%7D/pipeline%7Bprivate%7D/imports.nix) | Selects `{dotfiles}` subtrees from `root-vfs` (already resolved; design-system partials included). **Paths stay as-is** — no home-relative rewrite here. |
| `raw-dotfiles` | same file | Drops `{include}`, `{build}`, `{convert}`, `{private}` files — the raw-copy set. |
| `evaluated-nix-dotfiles` | [nix.nix](../src/dotfile-symlinking%7Bmodules:user%7D/pipeline%7Bprivate%7D/nix.nix) | Walks the `.nix` leaves of the `{dotfiles}` set and re-binds each already-attached `expr` with the pipeline's module args (`file.expr args`); no `file-dir` is threaded. |
| `converted-nix-dotfiles` | same file | Serialises `{convert:json}` / `{convert:ini}` files' `.expr` to text via `lib.generators`. |
| `sass-build-tree` | [sass.nix](../src/dotfile-symlinking%7Bmodules:user%7D/pipeline%7Bprivate%7D/sass.nix) | Materialises all `.scss` into one clean source tree in a derivation and keeps both `{ drv, dir }`. |
| `sass-load-flags` | same file | Collects `{include:sass}` dirs as ready-to-use `--load-path` flags. |
| `built-sass-dotfiles` | same file | Compiles `{build:sass}` entry points to `.css` via `dart-sass`. |
| `home-files` | [result.nix](../src/dotfile-symlinking%7Bmodules:user%7D/pipeline%7Bprivate%7D/result.nix) | Merges all stages; applies `{ext:…}` renames; **rewrites each path to its `~`-relative home path** (`to-home-path`); collapses to `home.file`. |

### Where the home-relative rewrite happens — and why it's last

`{dotfiles:PATH}` gives a path **relative to `~`**, replacing everything to its left. `PATH` uses `|` to separate segments (local convention, not sundry tag syntax): `{dotfiles:.config|waybar}` → `~/.config/waybar/`.

This rewrite lives in `home-files`'s `to-home-path`, applied only when building the `home.file` key — **not** in `dotfile-sources`. The VFS node's `path` stays in its original (source-tree) coordinates through every stage. This is deliberate: `sass-load-flags` computes `lib.take tag-pos path`, which relies on `tag-pos` (an index into the node's `tag-list`) still indexing `path`. Rewriting `path` early — but not `tag-list` — desynchronises the two, and `take` overshoots into file paths instead of include dirs. See [gotchas.md](gotchas.md).

## Tag syntax in file/directory names

Tags are embedded in path segments as `{key}` or `{key:value}`; multiple values are comma-separated (`{key:v1,v2}`). `sundry.vfs` parses them — see `~/sundry/.agent-docs/data-model.md` and `tag-matching.md`.

| Tag | Where | Meaning |
|---|---|---|
| `{dotfiles:seg\|nested}` | directory | Marks the subtree as a dotfile source and sets its `~`-relative destination. `\|` splits sub-segments. |
| `{convert:json}` / `{convert:ini}` | file | `.nix` evaluates to an attrset; pipeline serialises it to JSON / INI text. |
| `{ext:ext}` | file | Overrides the output extension. Bare `{ext}` strips the extension entirely. |
| `{build:sass}` | file | This `.scss` is a Sass entry point — compile to `.css`. |
| `{include:sass}` | directory | Sass include path. The `--load-path` is the dir **above** the tagged segment (`lib.take tag-pos path` in the Sass build tree derivation). |
| `{private}` | file or dir | Source-only helper, excluded from all discovery (module *and* dotfile). E.g. `settings{private}/`, the `pipeline{private}/` dir, sing-box's `config{private}/`. |
| `{hosts:name}` | file or dir | Only built for the named host. |

## Example: VS Code settings

```
applications/user{modules:user}/vscode/
  program.nix                                       → HM module (installs vscode)
  extensions.nix                                    → HM module
  config{dotfiles:.config|Code|User}/
    settings{convert:json}.nix                      → ~/.config/Code/User/settings.json
    keybindings{convert:json}.nix                   → ~/.config/Code/User/keybindings.json
    settings{private}/                                → excluded; read by settings.nix through root-vfs
```

`{dotfiles:.config|Code|User}` pins the destination. `settings.nix` reads the `{private}`-tagged helpers from `root-vfs.src.applications.user.vscode.config.settings` itself; `{private}` keeps them out of the output.

## Example: waybar

```
desktop-environment/user{modules:user}/applications/waybar/
  package.nix                                     → HM module (installs waybar)
  config{dotfiles:.config|waybar}/
    config{convert:json}{ext:jsonc}.nix           → ~/.config/waybar/config.jsonc
    style{build:sass}.scss                        → ~/.config/waybar/style.css
    waybar{include:sass}/                          → Sass load-path, not emitted
```

The module and its dotfiles live together. `{dotfiles:.config|waybar}` opts the subtree into the dotfile pipeline and pins its destination; the module `package.nix` beside it is picked up by module discovery, not the dotfile pipeline.

## Adding a new dotfile

1. Put it under `src/…/`, next to the module it belongs to, and tag the containing directory `{dotfiles:PATH}` with the `|`-separated home path.
2. If it's a Nix expression to serialise, add `{convert:json}` or `{convert:ini}` to the filename.
3. If it's a `.scss` entry point, tag it `{build:sass}`; tag include-only dirs `{include:sass}`.
4. `git add` the new file (a flake only sees git-tracked files) and `nixos-rebuild switch`.
</content>
