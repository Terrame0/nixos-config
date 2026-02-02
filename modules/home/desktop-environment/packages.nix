{pkgs, ...}: {
  home.packages = with pkgs; [
    waybar
    hyprpaper
    mako
    wofi
    nautilus
    grim
    slurp
    wl-clipboard
  ];
}