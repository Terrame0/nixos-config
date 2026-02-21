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
    # -- force the use of nvidia drivers
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    __EGL_VENDOR_LIBRARY_FILENAMES = "/run/opengl-driver/share/glvnd/egl_vendor.d/10_nvidia.json";
    __EGL_EXTERNAL_PLATFORM_CONFIG_DIRS = "/run/opengl-driver/share/egl/egl_external_platform.d";
  };

  # -- using an unstable version (overridden in an overlay)
  programs.hyprland = {
    withUWSM = true;
    package = pkgs.hyprland;
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland
  ];
}
