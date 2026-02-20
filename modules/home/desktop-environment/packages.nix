{pkgs, ...}: {
  home.packages = with pkgs; [
    waybar
    hyprpaper
    mako
    wofi

    # -- screenshots
    grim
    slurp
    wl-clipboard
  ];
}
