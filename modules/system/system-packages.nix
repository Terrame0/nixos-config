{
  pkgs,
  nixos-update-script,
  ...
}: {
  environment.systemPackages = with pkgs; [
    sops
    keyd
    v2rayn
    nix-ld
    nixos-update-script.packages.${pkgs.system}.default
  ];
}
