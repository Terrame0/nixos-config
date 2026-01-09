{pkgs, ...}: {
  # -- desktop environment
  services.desktopManager.gnome.enable = true;

  # -- login screen
  services.displayManager.gdm.enable = true;

  # -- remove gnome preinstalled apps
  documentation.nixos.enable = false;
  services.xserver.excludePackages = [pkgs.xterm];
  environment.gnome.excludePackages = with pkgs; [
    cheese
    epiphany
    simple-scan
    yelp
    file-roller
    geary
    seahorse
    gnome-console
    gnome-photos
    gnome-tour
    gnome-contacts
    gnome-font-viewer
    gnome-logs
    gnome-maps
    gnome-music
    gnome-photos
    gnome-weather
    gnome-disk-utility
    gnome-connections
  ];
}
