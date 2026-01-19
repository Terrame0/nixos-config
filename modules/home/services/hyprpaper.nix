{pkgs, ...}: {
  services.hyprpaper = {
    enable = true;
    settings = let
      wallpaper = pkgs.fetchurl {
        url = "https://w.wallhaven.cc/full/p9/wallhaven-p9m2qm.jpg";
        sha256 = "sha256-NLEKwYZ4gQFmYDU12sPgReP5EdtPuyor27gIeaVS60k=";
      };
    in {
      ipc = "on";
      splash = false;
      preload = ["${wallpaper}"];
      wallpaper = [
        "DP-1,${wallpaper}"
      ];
    };
  };
}
