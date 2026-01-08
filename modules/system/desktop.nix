{pkgs, ...}: {
  # -- desktop environment
  services.desktopManager.gnome.enable = true;

  # -- login screen
  services.displayManager.gdm.enable = true;

  # -- gnome extensions
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.vitals
    gnomeExtensions.clipboard-history
    gnomeExtensions.blur-my-shell
    gnomeExtensions.alttab-mod
    gnomeExtensions.fuzzy-app-search
  ];

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
