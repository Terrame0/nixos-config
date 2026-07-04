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

## sing-box 1.13.x has no `cache_file.store_selected`

Setting `experimental.cache_file.store_selected = true` makes `sing-box check` fail with `unknown field "store_selected"`. The field exists in newer sing-box schemas but not 1.13.x.

**Why:** it's a schema-version mismatch, not a runtime condition.

**Avoid:** don't add it to persist the manual selector choice — it doesn't exist here. Worse, if the updater's fallback swallows the `check` output, this bug is invisible: the service silently runs the last stored config forever while the new one is rejected on every restart. The updater now prints the `check` output on failure and validates the skeleton up front precisely so this class of bug fails loud (see [sing-box.md](sing-box.md)).
