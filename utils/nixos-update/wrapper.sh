#!/usr/bin/env bash

CURRENT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

exec nix develop "$CURRENT_DIR"#nixos-update --command bash "${CURRENT_DIR}/nixos-update.sh" "$@"