{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    waybar
    hyprpaper
    mako
    hyprlauncher
  ];
}
