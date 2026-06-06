{pkgs, ...}: {
  # -- xserver
  services.xserver = {
    enable = true;
    videoDrivers = ["nvidia"];
    displayManager.startx.enable = true;
  };

  environment.variables = {
    NIXOS_OZONE_WL = "1";
    GDK_BACKEND = "wayland,x11";
  };

  programs.hyprland = {
    withUWSM = true;
    enable = true;
    xwayland.enable = true;
    configType = "lua";
  };

  environment.systemPackages = with pkgs; [
    xdg-desktop-portal-hyprland
  ];
}
