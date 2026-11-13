{pkgs, ...}: let
  wallpapers = {
    black = pkgs.fetchurl {
      url = "https://upload.wikimedia.org/wikipedia/commons/thumb/5/50/Black_colour.jpg/960px-Black_colour.jpg?utm_source=commons.wikimedia.org&utm_campaign=index&utm_content=thumbnail";
      sha256 = "sha256-xycExewMjEwV0fElqNHi518JizKsWCj8vD3d1TK1Cv8=";
    };
    valley = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/yj/wallhaven-yj9357.jpg";
      sha256 = "sha256-OAcXF/YIDD3ZTF0OBaNiQ+Xsc1Fa35U8G65l45745IE=";
    };
    nix-black = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/pk/wallhaven-pkrqze.png";
      sha256 = "sha256-nhIUtCy/Hb8UbuxXeL3l3FMausjQrnjTVi1B3GkL9B8=";
    };
    nix-colorful = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/p9/wallhaven-p9pd23.png";
      sha256 = "sha256-7CMuETntiVUCKhUIdJzX+sf3F47GvuX2a61o4xbEzww=";
    };
    field = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/zp/wallhaven-zp5z2w.png";
      sha256 = "sha256-tqDgwCl97Gc2/8iZxAuf4Xpr1duDilKkYeBp2+7bhew=";
    };
  };
in {
  services.hyprpaper = {
    enable = true;
    settings = {
      ipc = true;
      splash = false;
      preload = ["${wallpapers.nix-black}"];
      wallpaper = [
        {
          monitor = "";
          path = "${wallpapers.nix-black}";
        }
      ];
    };
  };
}
