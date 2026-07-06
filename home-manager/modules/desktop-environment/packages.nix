{pkgs, ...}: {
  home.packages = with pkgs; [
    mako
    wofi
    nwg-launchers
  ];
}
