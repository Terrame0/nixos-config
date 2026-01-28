{pkgs, ...}: {
  home.packages = with pkgs; [
    waybar
    hyprpaper
    mako
    wofi
    hyprshot
  ];
}
