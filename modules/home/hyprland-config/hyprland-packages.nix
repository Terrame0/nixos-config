{pkgs,...}:{
  environment.systemPackages = with pkgs; [
    waybar
    hyprpaper
    mako
    hyprlauncher
  ];

  # -- remove preinstalled apps
  documentation.nixos.enable = false;
  services.xserver.excludePackages = [pkgs.xterm];
}