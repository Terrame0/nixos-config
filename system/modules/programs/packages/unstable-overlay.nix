{
  inputs,
  pkgs,
  ...
}: let
  pkgs-stable = import inputs.nixpkgs-unstable {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
in {
  nixpkgs.overlays = [
    (final: prev: {
      hyprland = pkgs-stable.hyprland;
      # lutris = pkgs-stable.lutris;
      # inkscape = pkgs-stable.inkscape;
    })
  ];
}
