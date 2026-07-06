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

`sass-load-paths` computes `lib.take tag-pos path`, where `tag-pos = get-tag-pos …` is an index into the node's **`tag-list`**. This only lands on the right prefix while `tag-list` and `path` share coordinates. Rewriting `path` (e.g. the `{dotfiles}` home-relative rebase) **without** rewriting `tag-list` breaks that: `tag-pos` stays large, the rebased `path` is short, and `take` overshoots — putting **file** paths into `--load-path` instead of include **dirs**, so Sass can't resolve `@use`.

**Why:** `take tag-pos path` silently assumes `tag-pos` indexes the *current* `path`. The old positional model kept them equal-length; home-relative rebasing drops the left prefix from `path` only.

**Avoid:** keep the node's `path` in source-tree coordinates through every stage that reads `tag-pos`/`tag-list`. The home-relative rewrite happens **last**, in `result`'s `to-home-path`, applied only to the emitted `home.file` key — never to the node in the tree. See [dotfile-symlinking.md](dotfile-symlinking.md).

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

## A path literal whose name carries a `{…}` tag breaks the store path it forces

Interpolating a path **literal** into a string (`"${./dir}/x"`, `import "${./. + "/config{parts}"}"`, or `origin = <path-literal>` later stringified) makes Nix copy that path into the store as its **own** object, named after the last segment. If that segment holds a `{…}` tag — as tag-named module dirs now do (`config{parts}`, `password-hashes{for-users}.yaml`) — the copy fails: `name '…{…}' … contains illegal character '{'`.

**Why:** stringifying a path literal forces a fresh store object; store-object *names* forbid `{`. A `{` living **inside** an already-valid store path (`config-root`, the copied git tree) is fine — it's only a new object's *name* that's rejected.

**Avoid:** never build these paths from a path literal (`./.`, `./secrets`). Reference them as **strings under `config-root`** — `"${config-root}/src/…/config{parts}"` is plain concatenation inside the already-copied repo, no new copy. Same trap in sundry's `vfs.dir.from-src`: pass it a **string** dir (`"${config-root}/…"`), not a path literal, or `listFilesRecursive` yields path literals whose `origin` re-copies each file under its tag name. **TODO:** a `sundry.path.rel config-root [segments…]` helper to build these `config-root`-relative strings without hand-writing the absolute prefix — which drifts when the tree is renamed, exactly as it did during the `{modules:…}` discovery migration ([structure.md](structure.md)). sing-box's `config-dir` string in [systemd-service.nix](../src/network%7Bmodules:system%7D/sing-box%7Bmodules:system%7D/systemd-service.nix) still hardcodes the full absolute prefix and had to be hand-fixed on every rename.
