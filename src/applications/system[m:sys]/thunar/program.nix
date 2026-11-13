{pkgs, ...}: {
  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      thunar-volman
      thunar-vcs-plugin
      thunar-media-tags-plugin
    ];
  };

  programs.xfconf.enable = true;
  services.tumbler.enable = true;

  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    gdk-pixbuf
    poppler
    ffmpegthumbnailer
    file-roller
  ];
}
