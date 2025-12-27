{pkgs, ...}: {
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "nixos-update" ''
      exec bash /etc/nixos/scripts/nixos-update/nixos-update.sh "$@"
    '')
  ];
}
