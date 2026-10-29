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
       (toString f.nixosConfigurations.desktop.config.systemd.services.sing-box.serviceConfig.ExecStartPre)))')
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

**Avoid:** after splitting a monolithic `.nix` into a directory, delete the old file in the same change. Module discovery now fails loud on this pair (`assert-unique-stems` in [`meta/system-assembly/glob-modules.nix`](../meta/system-assembly/glob-modules.nix)) because both paths would otherwise be imported as separate modules and drift.

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

**Avoid:** keep the node's `path` in source-file-tree coordinates through every stage that reads `tag-pos`/`tag-list`. The home-relative rewrite happens **last**, inline in `home-files` (`target-path` in `result.nix`), applied only to the emitted `home.file` key — never to the node in the tree. See [dotfile-symlinking.md](dotfile-symlinking.md).

The deeper lesson: **rewriting a directory node's `path` mid-pipeline is suspect on principle** — any later stage that correlates `path` with `tag-list` (via `tag-pos`) will misread it, because the rewrite moves one and not the other. The safe pattern is to derive the final path from `path` + `tag-list` **at the point of use** (as `target-path` does), leaving the tree in one coordinate system end to end. Treat "reform a directory's path early" as a smell, not a tool.

## `select-by-tag` drops non-matches; `reform-within-tag` keeps them

Swapping one for the other is not refactor-neutral. `reform-within-tag pred f` transforms only the matched branches and **passes everything else through untouched**. `select-by-tag pred` **discards** every branch that doesn't match.

**Why:** they answer different questions — "transform these, keep the rest" vs "keep only these".

**Avoid:** `imports` filters the module tree by `{dotfiles}` so dotfiles are told apart from real modules — but the filter matches at the **subtree root** (`{dotfiles:…}` dir) and keeps that whole subtree, including untagged children. That's what lets `{include:sass}` dirs survive: they carry no `{dotfiles}`/home tag of their own but sit *inside* a `{dotfiles}` subtree, so they're kept and Sass `@use "includes/…"` still resolves. Reaching for a per-node `{dotfiles}` filter (instead of subtree selection) would drop those include dirs and break the Sass `--load-path`.

## `{modules}` value queries need `deepest-tag`, not `tag`

`tag {modules = "system"}` matches if `system` appears **anywhere** in the path's tag chain (union). But `{modules}` is mutually exclusive — a co-located file like `desktop-environment/system{modules:system}/…` sitting under an (untagged) domain, or a lone `{modules:system}` file nested inside a `{modules:user}` domain, has **one** true level. Union would match *both* `filter-modules "system"` and `filter-modules "user"`, importing the same file into the NixOS list **and** the HM `imports` — a double-import that throws (e.g. `programs.hyprland` has no HM option).

**Why:** the deepest `{modules}` in the path is the real level; shallower ones are overridden, not additive.

**Avoid:** query the *value* with `deepest-tag {modules = …}` (nearest-in-chain wins), which [`glob-modules.nix`](../meta/system-assembly/glob-modules.nix)'s `filter-modules` does. Keep the plain `tag {modules = [];}` only for the **presence** check ("is this a module at all") — presence is the same under both operands; only value discrimination differs. `{hosts}` is queried the same way: its host gate uses `deepest-tag` too, so an inner host tag overrides an outer one. See [structure.md](structure.md).

## Hyprland must keep its own nixpkgs pin

Setting `hyprland.inputs.nixpkgs.follows = "nixpkgs-unstable"` breaks the build. The Hyprland flake's `hyprland-packages` overlay provides `hyprutils` from its own flake input (at the time of writing, 0.14.1), while `hyprtoolkit` is **not** overlaid and comes from the followed nixpkgs. A newer nixpkgs ships `hyprtoolkit 0.6.0`, whose `CMakeLists.txt` requires `hyprutils >= 0.14.2`, so configuration dies with:

```
Requested 'hyprutils >= 0.14.2' but version of hyprutils is 0.14.1
```

**Why:** the Hyprland overlay and the nixpkgs package set must move together; following the shared nixpkgs decouples them.

**Avoid:** leave `hyprland` without an `inputs.nixpkgs.follows` so it uses the nixpkgs snapshot from its own `flake.lock` (rev `2c423e03` pairs `hyprtoolkit 0.5.4` with `hyprutils 0.14.1`). If you do override it, pin a nixpkgs whose `hyprtoolkit` accepts the flake's `hyprutils` — do not point it at a moving branch.

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
lib.pipe (dirOf file.origin + "/settings{private}") [ … ]   # safe — still a path
lib.pipe "${dirOf file.origin}/settings{private}" [ … ]     # copies, aborts
```

`sundry.vfs.file.from-src` stores each file's raw `fs-path` as `origin`, so `dirOf file.origin` is a **path** whose basename can be a `{…}` tag. Extending it with `+` keeps it a path; interpolating it copies and aborts.

A `{` written directly in a path literal is a separate grammar error: write `./${"config{private}"}`, never `./config{private}`.

**sundry note.** A leaf `origin` may be a path, a string, or a derivation; `is-leaf` accepts all three, and `file.from-src` keeps the raw `fs-path` you pass. `sundry.path.to-store-str` leaves a store-resident path in place — returning a context-carrying string that points at the top-level store object, without copying — and copies only paths outside the store. A store-prefixed string is returned unchanged; if it carries no context it gains one on its store root, and if it already carries context it is not touched (so an unbuilt derivation output is not forced — `appendContext` checks that the path exists or is substitutable). A derivation is coerced to its output path with `toString`, which does not force the build either. The flake source is copied to the store as one hash-named object, so a `{…}` segment inside it is never itself a store-object name; only a path *outside* the store whose basename carries `{` triggers the abort above.

## `resolve-tags` is not idempotent — run it exactly once per subtree

`sundry.vfs.dir.resolve-tags` derives each node's `tag-list` from the `{…}` syntax in its `path`, then strips the braces from `path`. Running it a second time over an already-resolved tree throws: every node already carries a `tag-list`, and `resolve-tags` refuses to overwrite it.

**Why:** it is a one-way resolution pass, not a normalisation pass — the tags live in the very path syntax that resolution deletes, so a second run has nothing meaningful to read.

**Avoid:** resolve each raw tree exactly once, then merge the resolved trees with `sundry.vfs.dir.merge`. Assembly does two independent passes — `source-file-tree` in [`meta/system-assembly/each-host.nix`](../meta/system-assembly/each-host.nix) and the partials wrapper in that same file — and merges the results into `flake-file-tree`. Never call `resolve-tags` on `flake-file-tree` or on any other merged/already-resolved tree. See [design-system.md](design-system.md).

## Global `load-nix` attaches a lazy `expr` to every `.nix` leaf

`each-host.nix` pipes the whole repo tree through `sundry.vfs.dir.load-nix`, which sets `expr = import <origin>` on every `.nix` leaf. That `import` is a thunk — it does not run until `expr` is forced. Forcing `expr` on a **non-`.nix`** leaf fails: it has no valid import (the attribute is absent, or points at `import <non-nix>`).

**Why:** `load-nix` is applied uniformly to the resolved tree, so the attribute lands on `.nix` leaves whether or not anyone reads them; only Nix's laziness keeps hundreds of unattached module imports unevaluated.

**Avoid:** force `.expr` only on `.nix` leaves; read `.md`, `.yaml`, and tag-only leaves through `origin` or `text`, not `.expr`. The laziness is also the benefit — attaching `expr` to every module is free, and only forcing a leaf pays for its `import`.

## An MTU of 1500 on a 1492-byte path is a silent black hole

An interface announces 1500, but a PPPoE WAN carries only 1492. Full-size packets vanish, and the ICMP "fragmentation needed" that would repair it never comes back, so PMTUD never kicks in.

**Why:** TCP completes the handshake on small packets, then stalls on the first full-size segment — typically the certificate in a TLS handshake or the first data burst. From the outside it looks exactly like a dead server, while the connect itself succeeds.

**Avoid:** measure before trusting an MTU. `ping -M do -s 1472 <host>` fails and `-s 1464` passes when the path is really 1492. Then set the default in [networking.nix](../src/network%7Bmodules:system%7D/networking.nix) through the `[connection-ethernet]` section (`"ethernet.mtu" = 1492`, quoted — an unquoted `ethernet.mtu` becomes a nested attrset that the INI generator rejects), matched by `type:ethernet` rather than an interface name that changes per machine. Keep the sing-box TUN lower (1400) for encapsulation headroom; see [sing-box.md](sing-box.md).

## `vfs.dir.get-relative-to` matches a tag-free path against a `{…}`-tagged directory

`sundry.vfs.dir.get-relative-to root ./config flake-file-tree` finds the subtree whose path segment is written `config{private}` — the `.nix` file only ever needs to name `config`. A path literal is resolved relative to the **importing file**, so `./config` means "the `config*` node beside this module", not "`config` at the repo root".

**Why:** the first argument is the root the tree was built from (`root = ./.` from [flake.nix](../flake.nix), threaded through `meta-args`). The function strips that root from the path, splits the remainder into segments, strips `{…}` blocks from each segment (`strip-between`), and looks up the cleaned path first, falling back to the literal path. So `./config` from `src/shell{modules:user}/nushell/program.nix` lands on `.../nushell/config{private}`.

**Avoid:** when a module owns a tagged subtree, reach it with `sundry.vfs.dir.get-relative-to root ./<untagged-name> flake-file-tree` rather than spelling the full `flake-file-tree.src...` chain — the chain must encode tags (`flake-file-tree.src.shell.nushell."config{private}"`) and breaks when the tag changes, while the literal only names the directory. The lookup needs `sundry` and `root` in scope, so add them to the module's arguments when they are not already there.


## Cloudflare hands out a throttled edge for this subnet, stalling `*.cachix.org`

`*.cachix.org` lives behind Cloudflare, and Cloudflare answers with different anycast addresses depending on EDNS Client Subnet. For the Rostelecom subnet here (`77.82.103.0/24`) it returns `8.6.112.5` and `8.47.69.5`; for European subnets it returns `104.26.12.82` / `172.67.74.194`. All of them are genuinely Cloudflare — `8.x` is Cloudflare's leased Level 3 space, so it is absent from the 14 ranges at <https://www.cloudflare.com/ips-v4>.

One of those edges, `8.6.112.5`, is throttled on this line: the TCP and TLS handshakes succeed and about 1380 bytes arrive, then transfer stops at roughly 90 B/s. It is deterministic (same byte count every attempt) and independent of SNI, so it is path-level shaping of that IP, not a server fault — `8.47.69.5` from the same range moves 300 KB/s.

**Why it stalls rebuilds:** nix opens a HTTP/2 connection, gets the first headers, then waits. With `download-attempts = 5` and `stalled-download-timeout = 300` that is 25 minutes per narinfo, which reads as "the update hangs forever". `curl` shows the same thing as `Less than 1 bytes/sec transferred the last 300 seconds`.

**Avoid:** do not treat it as DNS poisoning — every answer is a real Cloudflare address, and hardcoding one is fragile. Point the resolver at one that does not forward the local subnet, so Cloudflare returns a different (unthrottled) edge. Quad9 answers `104.26.12.82` here, which is why [networking.nix](../src/network%7Bmodules:system%7D/networking.nix) lists `9.9.9.9` first. To diagnose, compare `dig +short @9.9.9.9 host A` with `@1.1.1.1`, then measure throughput against each returned IP with `curl --resolve host:443:<ip>`. Do not "fix" it by dropping the cachix substituters: that turns ~700 cached derivations into source builds.

## A dead substituter is only a warning, and its response body is never shown

When a binary cache is gone, nix logs `warning: unable to download …` and silently falls back to building from source. The HTTP response body — which is where caches usually announce a migration — never reaches the log. A rotated cache therefore looks like a normal, slow build.

**Why:** substituters are advisory. Losing one is a valid state, so it cannot be fatal, and nix discards the body once the status is not 200.

**Avoid:** probe a cache by hand before believing it is merely slow — `curl -sS <cache>/nix-cache-info`. The `cachyos` cache answered `400` with `Binary cache migrated: <issue link>` while every build quietly compiled the kernel. Migration usually rotates the public key too, so re-enabling the old URL is not enough: take the new key from the notice and verify it against a real narinfo instead of trusting the text. The nix fingerprint is `1;<store-path>;<narHash as sha256:<base32>>;<narSize>;<refs,>` and the signature is Ed25519 over it, so any narinfo's `Sig` can be checked with the published key. Currently `cache.lantian.pub/lantian` is the live one.
