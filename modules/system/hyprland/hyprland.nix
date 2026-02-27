{pkgs, ...}: {
  # -- xserver
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    displayManager.startx.enable = true;
  };

  environment.variables = {
    # NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11";
    ELECTRON_OZONE_PLATFORM_HINT = "x11";
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
