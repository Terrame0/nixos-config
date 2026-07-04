# Repository structure

## Layout

```
nixos-config/
├── flake.nix                  — entry point; defines hosts and wires all inputs
├── system/modules/            — NixOS system-level modules
│   ├── core/                  — users, locale, fonts, sops, sudo, state-version, package-management, update-script
│   ├── hardware/              — boot, graphics, sound, bluetooth, swap, networking
│   │   ├── desktop{hosts:desktop}/  — desktop-only hardware config
│   │   └── laptop{hosts:laptop}/   — laptop-only: hardware config + asusd (ASUS fan/aura)
│   ├── desktop-environment/   — hyprland, uwsm
│   ├── programs/applications/ — nix-ld, steam, throne
│   ├── programs/services/     — blueman, dbus, keyd, keyring, ssh-daemon, virtual-filesystems
│   └── sing-box/              — VPN proxy service (see sing-box.md)
└── home-manager/
    ├── modules/               — Home Manager modules (imported per-host same as system)
    │   ├── core/              — state-version, dotfile-symlinking hook
    │   ├── desktop-environment/ — packages, autostart, xdg, gtk-theme, default-apps
    │   └── programs/
    │       ├── applications/  — alacritty, direnv, firefox, git, mpv, ssh, thunar, vs-code, yt-dlp, zsh
    │       ├── packages/      — cli-utilities, desktop-utilities
    │       └── services/      — cliphist, hyprpaper, polkit
    └── dotfile-symlinking/    — dotfile pipeline (see dotfile-symlinking.md)
        ├── pipeline/          — pipeline stages: imports, nix, sass, result
        └── src/               — dotfile sources with tag annotations in directory/file names
```

## Multi-host setup

Two hosts are declared in `flake.nix`: `desktop` and `laptop`. Both are built from the same module tree — host-specific files are gated with `{hosts:desktop}` / `{hosts:laptop}` tags in their path, and the `filter-modules` function in `flake.nix` selects only the appropriate files for each host.

Home Manager runs as a NixOS module, not standalone. Apply all changes with `nixos-rebuild switch`.

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
