{pkgs, ...}: {
  home.packages = with pkgs; [
    pcsx2

    freecad
    lazarus-qt6
    eog
    gedit
    onlyoffice-desktopeditors
    baobab
    inkscape
    rawtherapee
    pinta
    aria2
  ];
}
