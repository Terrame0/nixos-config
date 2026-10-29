{pkgs, ...}: {
  home.packages = with pkgs; [
    # freecad
    # lazarus-qt6
    # rawtherapee
    # inkscape
    pcsx2
    eog
    gedit
    onlyoffice-desktopeditors
    baobab
    pinta
    aria2
  ];
}
