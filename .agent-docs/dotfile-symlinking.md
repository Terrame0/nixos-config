# Dotfile symlinking pipeline

Dotfiles are produced by a custom pipeline under [src/dotfile-symlinking[m:usr]/](../src/dotfile-symlinking%5Bm:usr%5D/). It turns tagged source files into `home.file` entries that Home Manager symlinks into place. Sources are dotfiles tagged inline in the module tree — a dotfile lives in the same folder as the module it belongs to.

## How it works

[default.nix](../src/dotfile-symlinking%5Bm:usr%5D/default.nix) drives it:

1. It collapses `sundry.vfs.tree.get-relative-to root ./pipeline flake-file-tree` and evaluates each stage file as `file.expr args`, using the `expr` the global `load-nix` already attached.
2. The stages are merged and run through `sundry.attrs.resolve-deps` — a dependency-aware evaluator that orders stages by their declared `deps`.
3. The final `home-files` key is assigned to `home.file`.

The pipeline takes the shared `root` only as the lookup anchor — it starts from its own subtree, obtained with `sundry.vfs.tree.get-relative-to root ./pipeline flake-file-tree`, where `.expr` is already present. The `./pipeline` literal resolves to the cleaned node whose on-disk name is `pipeline[m:-]`. The pipeline directory is tagged `[m:-]` so its own files are never mistaken for dotfile sources or modules.

## Tag syntax

Tags are embedded in path segments as `[key]` or `[key:value]`; multiple values are comma-separated (`[key:v1,v2]`). The brackets are not sundry's built-in default — [`meta/system-assembly/each-host.nix`](../meta/system-assembly/each-host.nix) imports sundry with `config.vfs.tags = { lsep = "["; rsep = "]"; }`, so the whole repo uses the short `[…]` form and every tag key stays a single short word. `sundry.vfs` parses the segments — see [tag-resolution.md](https://github.com/Terrame0/sundry/blob/main/.agent-docs/tag-resolution.md) and [tag-matching.md](https://github.com/Terrame0/sundry/blob/main/.agent-docs/tag-matching.md).

Keys are deliberately terse because they appear in every directory name:

| Key | Where | Meaning |
|---|---|---|
| `[dot:seg\seg]` | directory or file | Marks the subtree (or the file itself) as a dotfile source and sets its `~`-relative destination. `\` splits sub-segments. |
| `[mk:json]` / `[mk:ini]` | file | `.nix` evaluates to an attrset; pipeline serialises it to JSON / INI text. |
| `[mk:css]` | file | This `.scss` is a Sass entry point — compile to `.css`. |
| `[i:sass]` | directory | Sass include path. The `--load-path` is the dir **above** the tagged segment (`lib.take tag-pos path` in the Sass build-tree derivation). |
| `[ext:ext]` | file | Overrides the output extension. Bare `[ext]` strips the extension entirely. |
| `[exec]` | file | Marks the emitted `home.file` entry as executable. The executable bit is **never** inferred from the extension. |
| `[m:-]` | file or dir | Private: source-only helper, neither a module nor a dotfile — excluded from **both** discoveries. E.g. `settings[m:-]/`, `pipeline[m:-]/`, sing-box's `config[m:-]/`. |
| `[x]` | file or dir | Disabled: a module (or dotfile subtree) kept in the tree but switched off. Excluded the same way, but the intent is "off", not "not a source". E.g. `searx[x]/`. |
| `[h:name]` | file or dir | Only built for the named host. |
| `[m:sys]` / `[m:usr]` | file or dir | Module and its level — see [structure.md](structure.md). |

## Source: the module tree

`dotfile-sources` selects only the `[dot:…]` subtrees from `flake-file-tree`, the repo's already-resolved VFS tree ([imports.nix](../src/dotfile-symlinking%5Bm:usr%5D/pipeline%5Bm:-%5D/imports.nix)):

| Root | Selection | Destination path comes from |
|---|---|---|
| `flake-file-tree` (whole repo) | only subtrees tagged `[dot:…]` | the `[dot:PATH]` tag value |

`flake-file-tree` already contains the design-system partials: [`meta/system-assembly/each-host.nix`](../meta/system-assembly/each-host.nix) merges `design-system.partials-file-tree` (tagged `[dot:.design-system]`) into the tree before any pipeline stage runs, so `dotfile-sources` sees them as ordinary `[dot]` subtrees. Tag resolution happens when `flake-file-tree` is built, not in the pipeline.

The tree also holds real modules, so a dotfile there **must** carry `[dot:PATH]` both to opt in and to state where it lands. This lets a feature keep its module and its dotfiles side by side (e.g. `waybar/package.nix` next to `waybar/config[dot:.config\waybar]/`).

The `[dot]` selection is the mirror of module discovery in [glob-modules.nix](../meta/system-assembly/glob-modules.nix): discovery *excludes* `[dot]` subtrees, dotfile discovery *includes* only them — the two never claim the same file.

## Tag model: nouns classify, verbs process

The tag vocabulary splits along one axis:

- **Nouns — ingest class** (mutually exclusive): `[m:sys]` / `[m:usr]` for a module and its level, `[m:-]` for a private helper that is neither, `[dot:PATH]` for a dotfile. A file belongs to exactly one class — a module, a dotfile, or neither. `[x]` is orthogonal: it marks a subtree as present but off.
- **Verbs — processing within a class**: `[mk:…]` (produce an emitted file in the named format), `[i:sass]` (make this dir an include path), `[ext:…]`, `[exec]`. Only meaningful inside `[dot]` — a `.nix` module ingests as-is, so it carries no verbs.

`[mk:json]` and `[mk:css]` share one key but are different operations: `json`/`ini` are pure per-file serialisations (attrset → text via `lib.generators`), `css` is a compile that pulls `[i:sass]` load-paths and can fail. The key answers "what does this file become", not "which tool runs". `[exec]` is orthogonal to both: it only sets the executable bit on the emitted `home.file` entry.

## Pipeline stages

| Stage | File | What it does |
|---|---|---|
| `dotfile-sources` | [imports.nix](../src/dotfile-symlinking%5Bm:usr%5D/pipeline%5Bm:-%5D/imports.nix) | Selects `[dot]` subtrees from `flake-file-tree` (already resolved; design-system partials included) and drops `[m:-]` (private) and `[x]` (disabled) files and dirs. **Paths stay as-is** — no home-relative rewrite here. |
| `raw-dotfiles` | same file | Drops `[i]` and `[mk]` leaves — the raw-copy set. |
| `evaluated-nix-dotfiles` | [nix.nix](../src/dotfile-symlinking%5Bm:usr%5D/pipeline%5Bm:-%5D/nix.nix) | Walks the `.nix` leaves of the `[dot]` set and re-binds each already-attached `expr` with the pipeline's module args (`file.expr args`); no `file-dir` is threaded. |
| `converted-nix-dotfiles` | same file | Serialises `[mk:json]` / `[mk:ini]` files' `.expr` to text via `lib.generators`. |
| `sass-build-tree` | [sass.nix](../src/dotfile-symlinking%5Bm:usr%5D/pipeline%5Bm:-%5D/sass.nix) | Materialises all `.scss` into one clean source tree in a derivation and keeps both `{ drv, dir }`. |
| `sass-load-flags` | same file | Collects `[i:sass]` dirs as ready-to-use `--load-path` flags. |
| `built-sass-dotfiles` | same file | Compiles `[mk:css]` entry points to `.css` via `dart-sass`. |
| `home-files` | [result.nix](../src/dotfile-symlinking%5Bm:usr%5D/pipeline%5Bm:-%5D/result.nix) | Merges all stages; applies `[ext:…]` renames and `[exec]`; **rewrites each path to its `~`-relative home path**; collapses to `home.file`. |

### Where the home-relative rewrite happens — and why it's last

`[dot:PATH]` gives a path **relative to `~`**, replacing everything to its left. `PATH` uses `\` to separate segments (local convention, not sundry tag syntax): `[dot:.config\waybar]` → `~/.config/waybar/`.

This rewrite lives inline in `home-files` (`target-path` in `result.nix`), applied only when building the `home.file` key — **not** in `dotfile-sources`. The VFS node's `path` stays in its original (source-file-tree) coordinates through every stage. This is deliberate: `sass-load-flags` computes `lib.take tag-pos path`, which relies on `tag-pos` (an index into the node's `tag-list`) still indexing `path`. Rewriting `path` early — but not `tag-list` — desynchronises the two, and `take` overshoots into file paths instead of include dirs. See [gotchas.md](gotchas.md).

## Example: VS Code settings

```
applications/user[m:usr]/vscode/
  program.nix                                       → HM module (installs vscode)
  extensions/index.nix                              → HM module
  config[dot:.config\Code\User]/
    settings[mk:json].nix                           → ~/.config/Code/User/settings.json
    keybindings[mk:json].nix                        → ~/.config/Code/User/keybindings.json
    settings[m:-]/                                  → excluded; read by settings[mk:json].nix through flake-file-tree
```

`[dot:.config\Code\User]` pins the destination. `settings[mk:json].nix` reads the `[m:-]`-tagged helpers itself with `sundry.vfs.tree.get-relative-to root ./settings flake-file-tree` (the `./settings` literal matches `settings[m:-]`); `[m:-]` keeps them out of the output.

## Example: waybar

```
desktop-environment/user[m:usr]/applications/waybar/
  package.nix                                     → HM module (installs waybar)
  config[dot:.config\waybar]/
    config[mk:json][ext:jsonc].nix                → ~/.config/waybar/config.jsonc
    style[mk:css].scss                            → ~/.config/waybar/style.css
    waybar[i:sass]/                               → Sass load-path, not emitted
```

The module and its dotfiles live together. `[dot:.config\waybar]` opts the subtree into the dotfile pipeline and pins its destination; the module `package.nix` beside it is picked up by module discovery, not the dotfile pipeline.

## Adding a new dotfile

1. Put it under `src/…/`, next to the module it belongs to, and tag the containing directory `[dot:PATH]` with the `\`-separated home path.
2. If it's a Nix expression to serialise, add `[mk:json]` or `[mk:ini]` to the filename.
3. If it's a `.scss` entry point, tag it `[mk:css]`; tag include-only dirs `[i:sass]`.
4. If it must be executable, tag it `[exec]` — e.g. `screenshot[exec].sh`.
5. `git add` the new file (a flake only sees git-tracked files) and `nixos-rebuild switch`.
