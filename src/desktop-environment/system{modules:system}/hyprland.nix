{
  inputs,
  pkgs,
  ...
}: {
  environment.variables = {
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11";
  };

  programs.hyprland = {
    withUWSM = true;
    enable = true;
    xwayland.enable = true;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  xdg.portal = {
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.hyprland.default = [
      "hyprland"
      "gtk"
    ];
  };
}
