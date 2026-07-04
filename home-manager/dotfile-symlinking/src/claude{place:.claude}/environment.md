# Environment

System and tooling context for this machine.

## OS and package management

- **NixOS** — declarative, immutable OS. No `apt`, `pacman`, or similar.
- **Home Manager** — user-level config (dotfiles, packages, VS Code settings) is declared in `.nix` files and built into `/nix/store`. The resulting files are symlinks into the store and are read-only. Home Manager runs as a NixOS module (not standalone), so it is applied via `nixos-rebuild switch`, not `home-manager switch`.
- **Flakes** — both NixOS config and Home Manager use nix flakes (`flake.nix` + `flake.lock`).

To apply changes to system or user config: edit the relevant `.nix` file in `~/nixos-config` (see below). Never edit symlinked files directly — changes are lost on the next rebuild.

**Do not run `nixos-rebuild switch` or any variant that writes to the bootloader.** Rebuilding and switching the active system generation is the user's decision.

## Repositories

| Repo | Local path | Remote |
|---|---|---|
| NixOS + Home Manager config | `~/nixos-config` | `git@github.com:Terrame0/nixos-config.git` |
| sundry | `~/sundry` | `git@github.com:Terrame0/sundry.git` |

`nixos-config` declares the full system — installed packages, services, Home Manager modules, and user config. It has its own `.agent-docs/` with project-specific context; read it before making changes there. `nixos-config` depends on `sundry` as a flake input.

## Shell and tools

- Shell: **zsh**
- Formatter: **alejandra** (Nix)
- LSP: **nixd**
- Editor: **VS Code** (user settings managed by Home Manager — see above)

## Adding tools temporarily

`nix shell nixpkgs#<package>` works and is the right way to add a tool for the current session without touching any config. Example:

```bash
nix shell nixpkgs#hello --command hello
```

To make a tool permanent, add it to the Home Manager config instead.
