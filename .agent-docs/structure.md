# Repository structure

## Layout

Modules live in one tree, grouped by **domain** (what a feature *is*), not by privilege level. Whether a module is system- or user-level is a **tag** (`{modules:system}` / `{modules:user}`), not which root it sits in.

```
nixos-config/
├── flake.nix          — entry point; wires inputs, delegates host/module assembly to meta/system-assembly/
├── src/               — feature modules, grouped by domain
│   ├── nixos/         — OS foundation: nix, nixpkgs, locale, state-version, update-script
│   ├── hardware/      — boot, graphics, sound, bluetooth, networking, swap, per-host, asusd, keyd
│   ├── security/      — sops, keyring, sudo
│   ├── network/       — sing-box (VPN, see sing-box.md), throne, ssh-daemon
│   ├── applications/  — steam, nix-ld, dbus, thunar (sys); alacritty, firefox, mpv, vscode, yt-dlp (user)
│   ├── desktop-environment/ — hyprland, uwsm, fonts (sys); waybar, wofi, gtk-theme, cliphist, autostart, xdg (user)
│   ├── shell/         — zsh, starship, git, ssh, direnv (user)
│   └── dotfile-symlinking/ — the dotfile pipeline, as a user module (see dotfile-symlinking.md)
└── meta/    — foundation for modules, but not itself a module
    ├── system-assembly/ — host table and tag-based module discovery, wired by flake.nix
    ├── design-system/   — typed tokens and consumer-native partials (see design-system.md)
    └── settings/        — shared meta settings, read as a special arg
```

## What `meta/` is — and the two kinds inside it

`meta/` holds everything that is **foundation for modules but not itself a module** — it declares no NixOS/HM option, so module discovery skips it. It spans two different kinds:

| Kind | Example | Nature |
|---|---|---|
| Machinery that **runs** | [system-assembly/](../meta/system-assembly/) | host table plus tag-based module discovery, invoked by `flake.nix` |
| Data that is **read** | [`design-system/`](../meta/design-system/), [`settings/`](../meta/settings/) | cross-domain tokens and shared settings |

The design system is **cross-domain** — `applications/` and `desktop-environment/` ingest the same tokens — so it belongs to no single `src/` domain; it sits above them in `meta/`. See [design-system.md](design-system.md).

Dotfiles live inline next to the module they belong to, tagged `{dotfiles:PATH}` — a feature's module and its dotfiles share one folder. The pipeline that emits them is itself a user module at `src/dotfile-symlinking{modules:user}/`. See [dotfile-symlinking.md](dotfile-symlinking.md).

## The `{modules:…}` level tag

A module's level is declared by a `{modules:system}` or `{modules:user}` tag in its path. The tag is placed at the **coarsest** point that is unambiguous, and inherited by everything below it:

- **Mono-level domain** — the whole domain is one level, so the tag sits on the domain directory itself: `hardware{modules:system}/`, `shell{modules:user}/`, `security{modules:system}/`, `network{modules:system}/`.
- **Mixed-level domain** — the domain has both system and user sides, so its directory is left **untagged** and the level is set on two sub-folders: `desktop-environment/system{modules:system}/` + `desktop-environment/user{modules:user}/`. Same for `applications/` and `nixos/`.

This asymmetry (tag-on-domain vs tag-on-subfolder) is deliberate: mono-domains never need subfolders, mixed ones do. Both patterns resolve to the same thing — every `.nix` inherits exactly one `{modules:…}` value from its nearest such tag.

### Deepest tag wins

`{modules:…}` is a mutually-exclusive noun tag — a file is exactly one level. When tags nest (a `{modules:system}` file inside a `{modules:user}` domain, e.g. co-locating a compositor-enable module with its user dotfiles), the **deepest** tag in the path wins, not the union. `filter-modules` in [flake.nix](../flake.nix) queries this with the `deepest-tag` operand; the outer presence-check (`tag {modules = [];}` — "is this a module at all") stays plain `tag`. See [gotchas.md](gotchas.md).

## Module discovery

`flake.nix` delegates to [`meta/system-assembly/glob-modules.nix`](../meta/system-assembly/glob-modules.nix), which scans the resolved VFS tree `root-vfs.src` and keeps a `.nix` file as a module when it:

1. carries a `{modules:…}` tag somewhere in its path (presence check), **and**
2. is not `{private}` (source-only helper) or `{dotfiles}` (a dotfile, not a module), **and**
3. passes the host gate: `{hosts:name}` matching the current host, or no `{hosts}` tag at all.

`filter-modules "system"` / `filter-modules "user"` then split the survivors by their deepest `{modules}` value into the NixOS module list and the Home Manager `imports`. Home Manager runs as a NixOS module, not standalone — apply all changes with `nixos-rebuild switch`.

## Multi-host setup

Three hosts are declared in [`meta/system-assembly/hosts.nix`](../meta/system-assembly/hosts.nix): `legion-y520`, `desktop`, and `tuf-f17`. They build from the same tree; host-specific files are gated with `{hosts:name}` in their path, and discovery selects only the matching host's files.

## Special args available in every module

| Arg | Value |
|---|---|
| `host` | host record from `meta/system-assembly/hosts.nix`: `{ name, username, system, system-state-version, cores }` |
| `root-vfs` | the repo's one resolved and loaded VFS tree: `{src, meta.settings, partials, …}` |
| `sundry` | library functions from the `sundry` flake input |
| `settings` | shared meta settings from `meta/settings/` |
| `inputs` | the flake's inputs |

`root` (the Nix path `./.`) is not a special arg: it is an internal parameter of [`meta/system-assembly/each-host.nix`](../meta/system-assembly/each-host.nix), used only as the input to the repo's single `sundry.vfs.dir.from-src`. `each-host.nix` builds the tree once — `from-src`, `resolve-tags`, then `load-nix` produce `repo-vfs`; the design system is evaluated from its own subtree; and `design-system.partials-vfs` is merged in to form `root-vfs`.

`load-nix` attaches a lazy `expr = import <origin>` to every `.nix` leaf, so a module reads a Nix expression by forcing `.expr` with its args. A module reaches its own subtree with `sundry.vfs.dir.get <path> root-vfs`, passing a **path literal relative to the module file** (e.g. `sundry.vfs.dir.get ./config root-vfs` from `src/shell{modules:user}/nushell/program.nix`), then `file.expr args` per leaf. `vfs.dir.get` strips `{…}` tags from both a path literal and a string, so `./config` also matches `config{private}`. Modules never build their own trees or paths; they navigate the shared `root-vfs`. Assembly code does the same (e.g. `sundry.vfs.dir.get ../../src root-vfs` and `sundry.vfs.dir.get ../settings root-vfs` in [glob-modules.nix](../meta/system-assembly/glob-modules.nix)), never through `root + "/…"`.

The username is no longer a top-level arg; modules read it as `host.username`.

## Inputs

| Input | Pinned to |
|---|---|
| `nixpkgs` | `nixos-26.05` |
| `nixpkgs-unstable` | `nixos-unstable` |
| `home-manager` | `release-26.05` |
| `hyprland` | latest (nixpkgs follows nixpkgs) |
| `sundry-input` | private repo `Terrame0/sundry` |
| `sops-nix` | latest |
| `nix4vscode` | latest |
| `nixos-update-script` | private repo `Terrame0/nixos-update-script` |
</content>
</invoke>
