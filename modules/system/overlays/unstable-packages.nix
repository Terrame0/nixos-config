{
  pkgs,
  config,
  ...
}: let
  unstable =
    import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
      sha256 = "1dx1giygw794fhmzaw14xda3ghv5393fx1icx911ffxfmbdia472";
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
