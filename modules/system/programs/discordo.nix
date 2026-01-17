{
  pkgs,
  nixos-update-script,
  ...
}: let
  unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  }) {};
  myOverlay = self: super: {
    discordo = unstable.discordo;
  };
in {
  nixpkgs.overlays = [myOverlay];
  environment.systemPackages = with pkgs; [
    keyd
    nix-ld
    pacproxy
    nixos-update-script.packages.${pkgs.system}.default
  ];
}
