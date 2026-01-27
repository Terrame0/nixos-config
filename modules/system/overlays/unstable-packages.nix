{pkgs, ...}: let
  unstable =
    import (builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
      sha256 = "09qwbfkvk3jmqlpgis4v1m1fmh7zffi8drybb03mjqa95bynbs99";
    }) {
      system = pkgs.stdenv.hostPlatform.system;
      config = {};
    };
  overlay = self: super: {
    hyprland = unstable.hyprland;
    nixd = unstable.nixd;
  };
in {
  nixpkgs.overlays = [overlay];
}
