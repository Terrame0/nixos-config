{pkgs, ...}: {
  home.packages = with pkgs; [
    xfce.thunar

    # -- thunar plugins
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.thunar-vcs-plugin
    xfce.thunar-media-tags-plugin

    # -- needed for
    # previews to work
    xfce.tumbler
    gdk-pixbuf
    poppler
    ffmpegthumbnailer
  ];
}
