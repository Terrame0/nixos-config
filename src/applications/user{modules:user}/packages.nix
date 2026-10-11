{pkgs, ...}: {
  home.packages = with pkgs; [
    lutris
    pcsx2

    freecad
    lazarus-qt6
    eog
    gedit
    onlyoffice-desktopeditors
    qbittorrent
    baobab
    inkscape
    rawtherapee
    pinta
    aria2
  ];
}
