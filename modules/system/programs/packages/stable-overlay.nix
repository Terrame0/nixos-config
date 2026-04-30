{
  nixpkgs-stable,
  pkgs,
  ...
}: let
  pkgs-stable = import nixpkgs-stable {
    inherit (pkgs) system;
    config.allowUnfree = true;
  };
in {
  nixpkgs.overlays = [
    (final: prev: {
      lutris = pkgs-stable.lutris;
      inkscape = pkgs-stable.inkscape;
    })
  ];
}
