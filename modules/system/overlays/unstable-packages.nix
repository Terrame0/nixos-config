{
  pkgs,
  config,
  ...
}: let
  unstable =
    import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
      sha256 = "03plivnr4cg0h8v7djf9g2jra09r45pmdiirmy4lvl2n1d4yb7ac";
    })
    {
      system = pkgs.stdenv.hostPlatform.system;
      config = config.nixpkgs.config;
    };
  overlay = final: prev: {
    hyprland = unstable.hyprland;
    mpvScripts = unstable.mpvScripts;
    mpv = unstable.mpv;
  };
in {
  nixpkgs.overlays = [overlay];
}
