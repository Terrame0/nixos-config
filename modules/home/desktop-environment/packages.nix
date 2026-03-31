{pkgs, ...}: {
  home.packages = with pkgs; [
    waybar
    mako
    wofi
  ];
}
