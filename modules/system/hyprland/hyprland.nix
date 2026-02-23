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
    # -- it appears that these are not needed as of now
    #QT_QPA_PLATFORM = "wayland;xcb";
    #SDL_VIDEODRIVER = "wayland";
    #CLUTTER_BACKEND = "wayland";
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
