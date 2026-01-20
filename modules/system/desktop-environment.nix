{pkgs, ...}: {
  # -- xserver
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    displayManager.startx.enable = true;
  };

  environment.sessionVariables = {
    # -- force apps to use wayland
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11,*";
    QT_QPA_PLATFORM = "wayland;xcb";
    SDL_VIDEODRIVER = "wayland";
    CLUTTER_BACKEND = "wayland";
    # -- force to use nvidia
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    # -- set gtk themes
    GTK_THEME = "Adwaita-dark";
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  programs.waybar.enable = true;

  programs.hyprland = {
    package = pkgs.hyprland;
    enable = true;
    xwayland.enable = true;
  };
  environment.systemPackages = with pkgs; [
    # -- hyprland
    #waybar
    hyprpaper
    mako
    hyprlauncher
  ];

  # -- remove preinstalled apps
  documentation.nixos.enable = false;
  services.xserver.excludePackages = [pkgs.xterm];
}
