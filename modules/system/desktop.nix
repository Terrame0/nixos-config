{pkgs, ...}: {
  # -- x11 and desktop environment
  services.xserver = {
    enable = true;
    desktopManager.gnome.enable = true;
    displayManager.gdm.enable = true;
    xkb = {
      layout = "us,ru";
      options = "grp:alt_shift_toggle";
    };
  };

  # -- gnome extensions
  environment.systemPackages = with pkgs; [
    gnome-tweaks
    gnomeExtensions.clipboard-history
    gnomeExtensions.battery-time
  ];

  # -- remove clutter
  documentation.nixos.enable = false;
  services.xserver.excludePackages = [pkgs.xterm];
  environment.gnome.excludePackages = with pkgs; [
    cheese # -- photo booth
    epiphany # -- web browser
    simple-scan # -- document scanner
    yelp # -- help viewer
    file-roller # -- archive manager
    geary # -- email client
    seahorse # -- password manager
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

  # -- totem fix (to use OpenGL ES)
  environment.variables = {
    GDK_GL = "gles";
  };

  # -- auto-login
  services.displayManager = {
    autoLogin.enable = true;
    autoLogin.user = "terrame";
  };
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
}
