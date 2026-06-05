{pkgs, ...}: let
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/yj/wallhaven-yj9357.jpg";
    sha256 = "sha256-OAcXF/YIDD3ZTF0OBaNiQ+Xsc1Fa35U8G65l45745IE=";
  };
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = [
        "${wallpaper}"
      ];
      wallpaper = [
        {
          monitor = "";
          path = "${wallpaper}";
        }
      ];
    };
  };
}
