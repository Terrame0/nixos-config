{pkgs, ...}: {
  home.packages = with pkgs; [
    # -- games
    lutris
    pcsx2

    # -- basic desktop utilities
    freecad
    eog
    gedit
    prismlauncher
    onlyoffice-desktopeditors
    qbittorrent
    baobab
    inkscape
    rawtherapee
    pinta
    aria2
  ];
}
