{pkgs,...}: {
  services.gvfs.enable = true;
  services.tumbler.enable = true;
  services.udisks2.enable = true;

  home.packages = with pkgs; [
    xfce.thunar
    
    xfce.thunar-archive-plugin
    xfce.thunar-volman
    xfce.thunar-vcs-plugin
    xfce.thunar-media-tags-plugin

    gdk-pixbuf
    poppler
    ffmpegthumbnailer
    librsvg
  ];
}
