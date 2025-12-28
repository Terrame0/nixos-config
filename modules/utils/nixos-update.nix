{pkgs, ...}: let
  nixos-update-script = pkgs.writeShellScriptBin "nixos-update" ''
    exec bash /etc/nixos/modules/utils/nixos-update.sh "$@"
  ''; # -- hardcoded the path becouse i couldnt find a workaround
in {
  environment.systemPackages = [nixos-update-script];
}
