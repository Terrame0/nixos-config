{pkgs, ...}: {
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11";
  };

  programs.hyprland = {
    withUWSM = true;
    enable = true;
    xwayland.enable = true;
  };

  xdg.portal.extraPortals = [pkgs.xdg-desktop-portal-gtk];
}
