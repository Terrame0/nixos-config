{
  pkgs,
  nixos-update-script,
  ...
}: {
  environment.systemPackages = with pkgs; [
    keyd
    nix-ld
    nixos-update-script.packages.${pkgs.system}.default
  ];
}
