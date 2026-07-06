# Repository structure

## Layout

Modules live in one tree, grouped by **domain** (what a feature *is*), not by privilege level. Whether a module is system- or user-level is a **tag** (`{modules:system}` / `{modules:user}`), not which root it sits in.

```
nixos-config/
├── flake.nix          — entry point; declares hosts, discovers modules by tag, wires inputs
├── src/               — feature modules, grouped by domain
│   ├── nixos/         — OS foundation: nix, nixpkgs, locale, state-version, update-script
│   ├── hardware/      — boot, graphics, sound, bluetooth, networking, swap, per-host, asusd, keyd
│   ├── security/      — sops, keyring, sudo
│   ├── network/       — sing-box (VPN, see sing-box.md), throne, ssh-daemon
│   ├── applications/  — steam, nix-ld, dbus (sys); alacritty, firefox, mpv, vscode, thunar, yt-dlp (user)
│   ├── desktop-environment/ — hyprland, uwsm, fonts (sys); waybar, wofi, gtk-theme, cliphist, autostart, xdg (user)
│   └── shell/         — zsh, starship, git, ssh, direnv (user)
└── infrastructure/    — build machinery, not a feature domain
    └── dotfile-symlinking/ — the dotfile pipeline (see dotfile-symlinking.md)
```

Dotfiles live inline next to the module they belong to, tagged `{dotfiles:PATH}` — a feature's module and its dotfiles share one folder. See [dotfile-symlinking.md](dotfile-symlinking.md).

## The `{modules:…}` level tag

A module's level is declared by a `{modules:system}` or `{modules:user}` tag in its path. The tag is placed at the **coarsest** point that is unambiguous, and inherited by everything below it:

- **Mono-level domain** — the whole domain is one level, so the tag sits on the domain directory itself: `hardware{modules:system}/`, `shell{modules:user}/`, `security{modules:system}/`, `network{modules:system}/`.
- **Mixed-level domain** — the domain has both system and user sides, so its directory is left **untagged** and the level is set on two sub-folders: `desktop-environment/system{modules:system}/` + `desktop-environment/user{modules:user}/`. Same for `applications/` and `nixos/`.

This asymmetry (tag-on-domain vs tag-on-subfolder) is deliberate: mono-domains never need subfolders, mixed ones do. Both patterns resolve to the same thing — every `.nix` inherits exactly one `{modules:…}` value from its nearest such tag.

### Deepest tag wins

`{modules:…}` is a mutually-exclusive noun tag — a file is exactly one level. When tags nest (a `{modules:system}` file inside a `{modules:user}` domain, e.g. co-locating a compositor-enable module with its user dotfiles), the **deepest** tag in the path wins, not the union. `filter-modules` in [flake.nix](../flake.nix) queries this with the `deepest-tag` operand; the outer presence-check (`tag {modules = [];}` — "is this a module at all") stays plain `tag`. See [gotchas.md](gotchas.md).

## Module discovery

`flake.nix` scans the whole repo from `config-root` and keeps a `.nix` file as a module when it:

1. carries a `{modules:…}` tag somewhere in its path (presence check), **and**
2. is not `{parts}` (source-only helper) or `{dotfiles}` (a dotfile, not a module), **and**
3. passes the host gate: `{hosts:name}` matching the current host, or no `{hosts}` tag at all.

`filter-modules "system"` / `filter-modules "user"` then split the survivors by their deepest `{modules}` value into the NixOS module list and the Home Manager `imports`. Home Manager runs as a NixOS module, not standalone — apply all changes with `nixos-rebuild switch`.

## Multi-host setup

Two hosts are declared in `flake.nix`: `desktop` and `laptop`. Both build from the same tree; host-specific files are gated with `{hosts:desktop}` / `{hosts:laptop}` in their path (e.g. under `hardware/`), and discovery selects only the matching host's files.

## Special args available in every module

| Arg | Value |
|---|---|
| `username` | `"terrame"` |
| `host` | `{ name, system, system-state-version }` |
| `config-root` | absolute path to repo root in the Nix store |
| `sundry` | library functions from the `sundry` flake input |

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
