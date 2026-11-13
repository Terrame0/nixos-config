{
  config,
  sundry,
  ...
}: let
  mk-path = suffix:
    sundry.vfs.path.get.str
    [config.home.homeDirectory suffix];
in {
  xdg.userDirs = {
    enable = true;
    createDirectories = true;

    documents = mk-path "documents";
    download = mk-path "downloads";
    pictures = mk-path "images";
    videos = mk-path "videos";
    music = mk-path "music";
    projects = mk-path "projects";

    desktop = null;
    templates = null;
    publicShare = null;
  };
}
