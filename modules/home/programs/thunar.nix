{pkgs, ...}: {
  # -- preview manager
  services.tumbler.enable = true;
  home.packages = with pkgs; [
    xfce.thunar

    # -- thunar plugins
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.thunar-vcs-plugin
    xfce.thunar-media-tags-plugin

    # -- preview providers
    gdk-pixbuf
    poppler
    ffmpegthumbnailer
    
    librsvg
  ];
}
