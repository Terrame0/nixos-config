{pkgs, ...}: {
  home.packages = with pkgs; [
    waybar
    mako
    wofi
    nwg-launchers
  ];
}
