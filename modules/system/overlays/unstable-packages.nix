{pkgs, ...}: let
  # unstable =
  #   import
  #   (fetchTarball {
  #     url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  #     sha256 = "03plivnr4cg0h8v7djf9g2jra09r45pmdiirmy4lvl2n1d4yb7ac";
  #   })
  #   {
  #     system = pkgs.stdenv.hostPlatform.system;
  #     config = {};
  #   };
  # overlay = final: prev: {
  #   hyprland = unstable.hyprland;
  # };
in {
  # nixpkgs.overlays = [overlay];
}
