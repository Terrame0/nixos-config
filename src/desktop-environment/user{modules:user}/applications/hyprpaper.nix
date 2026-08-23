{pkgs, ...}: let
  wallpaper = pkgs.fetchurl {
    url = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Black_colour.jpg/960px-Black_colour.jpg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail";
    sha256 = "sha256-xycExewMjEwV0fElqNHi518JizKsWCj8vD3d1TK1Cv8=";
    # url = "https://w.wallhaven.cc/full/yj/wallhaven-yj9357.jpg";
    # sha256 = "sha256-OAcXF/YIDD3ZTF0OBaNiQ+Xsc1Fa35U8G65l45745IE=";
  };
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = ["${wallpaper}"];
      wallpaper = [
        {
          monitor = "";
          path = "${wallpaper}";
        }
      ];
    };
  };
}
