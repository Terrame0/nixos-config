{pkgs, ...}: {
  # -- xserver
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    displayManager.startx.enable = true;
  };

  # environment.sessionVariables = {
  #   # -- force apps to use wayland
  #   NIXOS_OZONE_WL = "0";
  #   GDK_BACKEND = "wayland,x11,*";
  #   QT_QPA_PLATFORM = "wayland;xcb";
  #   SDL_VIDEODRIVER = "wayland";
  #   CLUTTER_BACKEND = "wayland";
  #   # -- force the use of nvidia drivers
  #   LIBVA_DRIVER_NAME = "nvidia";
  #   __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  # };

  environment.sessionVariables = {
  # -- force VSCode (and XWayland apps) to use X11
  NIXOS_OZONE_WL = "0";        # Electron uses X11
  GDK_BACKEND = "x11";         # GTK apps X11
  QT_QPA_PLATFORM = "xcb";     # Qt apps X11
  SDL_VIDEODRIVER = "x11";     # SDL apps X11
  CLUTTER_BACKEND = "x11";     # GTK3D apps X11

  # -- force NVIDIA drivers
  LIBVA_DRIVER_NAME = "nvidia";
  __GLX_VENDOR_LIBRARY_NAME = "nvidia";
};

  # -- using an unstable version (overridden in an overlay)
  programs.hyprland = {
    withUWSM = true;
    package = pkgs.hyprland;
    enable = true;
    xwayland.enable = true;
  };
}
