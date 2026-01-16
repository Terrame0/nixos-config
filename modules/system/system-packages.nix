{
  pkgs,
  nixos-update-script,
  ...
}: {
  environment.systemPackages = with pkgs; [
    firefox
    keyd
    nix-ld
    nixos-update-script.packages.${pkgs.system}.default
  ];
}
