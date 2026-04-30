{pkgs, ...}: {
  home.packages = with pkgs.xfce; [
    thunar

    # -- thunar plugins
    thunar-archive-plugin
    thunar-volman
    thunar-vcs-plugin
    thunar-media-tags-plugin

    # -- needed for
    # previews to work
    tumbler
    gdk-pixbuf
    poppler
    ffmpegthumbnailer
  ];
}
