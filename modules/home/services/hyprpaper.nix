{pkgs,...}: {
  services.hyprpaper = {
    enable = true;
    settings = let
      wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/p9/wallhaven-p9m2qm.jpg";
    sha256 = "";
  };
    in {
      ipc = "on";
      splash = false;
      preload = ["${wallpaper}"];
      wallpaper = [
        "DP-1,${wallpaper}"
      ];
      offset = ["0.0" "-0.2"];
    };
  };
}
