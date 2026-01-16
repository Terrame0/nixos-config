{
  pkgs,
  nixos-update-script,
  ...
}: {
  environment.systemPackages = with pkgs; [
    keyd
    v2rayn
    nix-ld
    nixos-update-script.packages.${pkgs.system}.default
  ];
}
