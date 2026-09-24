# Gotchas

Counter-intuitive traps that already bit someone and would bite again. Each entry: the rule, one line of why, and how to avoid it. Not a FAQ — if something is just "how the system works", it belongs in the topic doc that owns it.

## `nix eval --raw` returns a store path but does not realise it

`nix eval --raw .#...serviceConfig.ExecStartPre` prints a `/nix/store/...` path, but the derivation is **not built** — the path often does not exist on disk, so a follow-up `head`/`grep`/`cat` fails with "No such file or directory".

**Why:** `eval` computes the string; only `nix build` / `nix-store --realise` actually builds the output.

**Avoid:** to inspect a built artifact, get the `.drv` from the string's context and realise it:

```bash
DRV=$(nix eval --raw --impure --expr '
  let f = builtins.getFlake (toString ./.);
  in builtins.head (builtins.attrNames (builtins.getContext
       (toString f.nixosConfigurations.laptop.config.systemd.services.sing-box.serviceConfig.ExecStartPre)))')
nix-store -r "$DRV"   # now the out path exists
```

Do not chain `nix build --no-link` then read the path — with `--no-link` the GC can remove it before the next command runs.

## `builtins.getFlake` on a plain path fails on this repo

`builtins.getFlake "/abs/path/to/nixos-config"` fails with `the contents of the file '/nix/store/…/.git/index' cannot be represented as a Nix string`. The `git+file://` form succeeds, as do ordinary `nix build .#…` and the default `nixos option` cache.

**Why:** a plain path makes `getFlake` copy the working tree including `.git`, and evaluating the config then touches the git index. A `git+file://` ref and flake commands evaluate the git-tracked tree, which omits `.git`.

**Avoid:** call `getFlake` with a `git+file://` ref, not a plain path. `nixos option --no-cache` fails for this reason — it rebuilds the option list with a plain-path `getFlake` — so keep nixos-cli's default option cache.

## A flake only sees git-tracked files

`builtins.readFile ./foo.sh` and path interpolation `${./foo.jq}` fail at build time if the referenced file is new and untracked — the flake copies the git tree into the store, and untracked files are absent.

**Why:** flakes evaluate against the git tree, not the working directory.

**Avoid:** `git add` a newly created file before `nixos-update`/`nix build`, even without committing. The error message spells it out: *"To make it visible to Nix, run: git add …"*.

## A directory with `default.nix` wins over a same-named `.nix` file

`import ./sing-box-config` resolves to `sing-box-config/default.nix` when both `sing-box-config.nix` (a file) and `sing-box-config/` (a directory) sit side by side. The file becomes dead weight that still imports fine on its own but is never used.

**Why:** Nix prefers a directory's `default.nix` over a sibling file of the same stem.

**Avoid:** after splitting a monolithic `.nix` into a directory, delete the old file in the same change. Leaving it misleads readers (and the IDE opens the stale file), and the two copies silently drift.

## `sing-box check` rejects a `urltest`/`selector` with an empty `outbounds`

A bare config whose `urltest` has `outbounds = []` fails `sing-box check` with `FATAL: initialize outbound[…]: missing tags` — **before** it validates the rest of the schema.

**Why:** an empty selector/urltest is itself a schema error, and `check` stops at the first one.

**Avoid:** two consequences. (1) You cannot validate a bare skeleton for *other* schema bugs while a selector is empty — the empty-selector error masks them. The sing-box skeleton solves this with a `dummy` placeholder node the updater strips at merge time (see [sing-box.md](sing-box.md)). (2) When a `check` failure looks puzzling, remember it reports only the **first** error — fix it and re-run; there may be more behind it.

## `lib.splitString sep ""` returns `[""]`, not `[]`

Splitting an empty string yields a one-element list holding the empty string, not an empty list. In path work this is a bug: a path segment list `[""]` is "one empty segment" (→ stray `/`, `a//b`), not "no segments".

**Why:** `splitString` is "delimiter count + 1 elements"; zero delimiters → one element, which for `""` is `""` itself.

**Avoid:** in the dotfile pipeline, segment splits go through [`sundry.str.to-segments`](../../sundry/src/str/to-segments.nix) (`"" → []`), not raw `lib.splitString`. `vfs.path.from-str` uses it too. Reach for `to-segments` whenever a string becomes path segments; keep `lib.splitString` only for genuine string ops (`str.after`/`before`) where an empty element is meaningful.

## A VFS node's `path` and `tag-list` desync if you rewrite `path` mid-pipeline

`sass-load-flags` computes `lib.take tag-pos path`, where `tag-pos = get-tag-pos …` is an index into the node's **`tag-list`**. This only lands on the right prefix while `tag-list` and `path` share coordinates. Rewriting `path` (e.g. the `{dotfiles}` home-relative rebase) **without** rewriting `tag-list` breaks that: `tag-pos` stays large, the rebased `path` is short, and `take` overshoots — putting **file** paths into `--load-path` instead of include **dirs**, so Sass can't resolve `@use`.

**Why:** `take tag-pos path` silently assumes `tag-pos` indexes the *current* `path`. The old positional model kept them equal-length; home-relative rebasing drops the left prefix from `path` only.

**Avoid:** keep the node's `path` in source-tree coordinates through every stage that reads `tag-pos`/`tag-list`. The home-relative rewrite happens **last**, in `home-files`'s `to-home-path`, applied only to the emitted `home.file` key — never to the node in the tree. See [dotfile-symlinking.md](dotfile-symlinking.md).

The deeper lesson: **rewriting a directory node's `path` mid-pipeline is suspect on principle** — any later stage that correlates `path` with `tag-list` (via `tag-pos`) will misread it, because the rewrite moves one and not the other. The safe pattern is to derive the final path from `path` + `tag-list` **at the point of use** (as `to-home-path` does), leaving the tree in one coordinate system end to end. Treat "reform a directory's path early" as a smell, not a tool.

## `select-by-tag` drops non-matches; `reform-within-tag` keeps them

Swapping one for the other is not refactor-neutral. `reform-within-tag pred f` transforms only the matched branches and **passes everything else through untouched**. `select-by-tag pred` **discards** every branch that doesn't match.

**Why:** they answer different questions — "transform these, keep the rest" vs "keep only these".

**Avoid:** `imports` filters the module tree by `{dotfiles}` so dotfiles are told apart from real modules — but the filter matches at the **subtree root** (`{dotfiles:…}` dir) and keeps that whole subtree, including untagged children. That's what lets `{include:sass}` dirs survive: they carry no `{dotfiles}`/home tag of their own but sit *inside* a `{dotfiles}` subtree, so they're kept and Sass `@use "includes/…"` still resolves. Reaching for a per-node `{dotfiles}` filter (instead of subtree selection) would drop those include dirs and break the Sass `--load-path`.

## `{modules}` value queries need `deepest-tag`, not `tag`

`tag {modules = "system"}` matches if `system` appears **anywhere** in the path's tag chain (union). But `{modules}` is mutually exclusive — a co-located file like `desktop-environment/system{modules:system}/…` sitting under an (untagged) domain, or a lone `{modules:system}` file nested inside a `{modules:user}` domain, has **one** true level. Union would match *both* `filter-modules "system"` and `filter-modules "user"`, importing the same file into the NixOS list **and** the HM `imports` — a double-import that throws (e.g. `programs.hyprland` has no HM option).

**Why:** the deepest `{modules}` in the path is the real level; shallower ones are overridden, not additive.

**Avoid:** query the *value* with `deepest-tag {modules = …}` (nearest-in-chain wins), which [flake.nix](../flake.nix)'s `filter-modules` does. Keep the plain `tag {modules = [];}` only for the **presence** check ("is this a module at all") — presence is the same under both operands; only value discrimination differs. See [structure.md](structure.md).

## sing-box 1.13.x has no `cache_file.store_selected`

Setting `experimental.cache_file.store_selected = true` makes `sing-box check` fail with `unknown field "store_selected"`. The field exists in newer sing-box schemas but not 1.13.x.

**Why:** it's a schema-version mismatch, not a runtime condition.

**Avoid:** don't add it to persist the manual selector choice — it doesn't exist here. Worse, if the updater's fallback swallows the `check` output, this bug is invisible: the service silently runs the last stored config forever while the new one is rejected on every restart. The updater now prints the `check` output on failure and validates the skeleton up front precisely so this class of bug fails loud (see [sing-box.md](sing-box.md)).

## Keep a `{…}`-tagged path a path — never hand it to a string builtin

A path whose final segment carries a tag — for example `config{dotfiles:.config|Code|User}` — must stay a Nix path. Do not interpolate it, and do not pass it to `lib.hasSuffix` / `hasPrefix` / `hasInfix`, `lib.concatStrings*`, `builtins.toJSON`, `builtins.stringLength`, or `lib.substring`.

**Why:** Nix coerces a path to a string by copying it into the store **under its basename**. When that basename contains `{`, the copy aborts:

```
error: path '…-config{dotfiles:.config|Code|User}' is not a valid store path:
       name 'config{dotfiles:.config|Code|User}' contains illegal character '{'
```

`builtins.toString path` is the one path→string conversion that does not copy; interpolation `"${path}"` does.

**Avoid:** extend a path with `+`, which keeps it a path:

```nix
lib.pipe (file-dir + "/settings{private}") [ … ]   # safe — still a path
lib.pipe "${file-dir}/settings{private}" [ … ]     # copies, aborts
```

This surfaced when the repo root became a path. `sundry.vfs.file.from-src` stores each file's raw `fs-path` as `origin`, so `dirOf file.origin` in the `{convert:json}` pipeline is a **path** whose basename is a `{…}` tag. While the root was the context-carrying string `self.outPath`, `dirOf` yielded a string and interpolation was harmless.

A `{` written directly in a path literal is a separate grammar error: write `./${"config{private}"}`, never `./config{private}`.

**sundry note.** A leaf `origin` may be a path, a string, or a derivation; `is-leaf` accepts all three, and `file.from-src` keeps the raw `fs-path` you pass. `sundry.path.to-store` leaves a store-resident path in place — returning a context-carrying string that points at the top-level store object, without copying — and copies only paths outside the store. The flake source is copied to the store as one hash-named object, so a `{…}` segment inside it is never itself a store-object name; only a path *outside* the store whose basename carries `{` triggers the abort above.

## `resolve-tags` is not idempotent — run it exactly once per subtree

`sundry.vfs.dir.resolve-tags` derives each node's `tag-list` from the `{…}` syntax in its `path`, then strips the braces from `path`. Run it a second time over an already-resolved tree and there are no tags left to read, so it overwrites every `tag-list` with empty tag sets (an untagged segment resolves to `[{}]`).

**Why:** it is a one-way resolution pass, not a normalisation pass — the tags live in the very path syntax that resolution deletes.

**Avoid:** resolve each raw tree exactly once, then merge the resolved trees with `sundry.vfs.dir.merge`. Assembly does two independent passes — `files-vfs` in [`meta/system-assembly/each-host.nix`](../meta/system-assembly/each-host.nix) and `partials-vfs` in [`meta/design-system/default.nix`](../meta/design-system/default.nix) — and merges the results into `root-vfs`. Never call `resolve-tags` on `root-vfs` or on any other merged/already-resolved tree. See [design-system.md](design-system.md).
