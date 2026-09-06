{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.hyprland.nixosModules.default];
  programs.hyprland = {
    withUWSM = true;
    enable = true;
    xwayland.enable = true;
    portalPackage = inputs.hyprland.packages.${pkgs.system}.xdg-desktop-portal-hyprland;
  };

  environment.variables = {
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11";
  };

  xdg.portal = {
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.hyprland.default = [
      "hyprland"
      "gtk"
    ];
  };
}
