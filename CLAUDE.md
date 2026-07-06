# nixos-config

NixOS + Home Manager configuration for two hosts (`desktop`, `laptop`). Declared as a Nix flake; Home Manager runs as a NixOS module, so everything is applied via `nixos-rebuild switch`. The repo depends on the private `sundry` library for VFS and attribute utilities.

## Before working, read the relevant doc in `.agent-docs/`

- [structure.md](.agent-docs/structure.md) — overall repo layout, multi-host setup, special args, flake inputs.
- [dotfile-symlinking.md](.agent-docs/dotfile-symlinking.md) — how dotfiles are managed: pipeline stages, tag syntax, adding new dotfiles.
- [sing-box.md](.agent-docs/sing-box.md) — VPN proxy service: subscription updater, config skeleton, secrets.
- [secrets.md](.agent-docs/secrets.md) — sops-nix: how secrets are auto-derived from the `secrets/*.yaml` files, the age key, and `LoadCredential`.
- [gotchas.md](.agent-docs/gotchas.md) — counter-intuitive traps: nix eval vs build, flake git-tracking, empty sing-box selectors, and more.

When you add, rename, or remove a doc under `.agent-docs/`, update this index — and the import list below — in the same change so neither drifts from what's on disk.

@.agent-docs/structure.md
@.agent-docs/dotfile-symlinking.md
@.agent-docs/sing-box.md
@.agent-docs/secrets.md
@.agent-docs/gotchas.md
