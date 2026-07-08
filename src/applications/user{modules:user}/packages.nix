{pkgs, ...}: {
  home.packages = with pkgs; [
    # -- games
    wine-wayland
    winetricks
    pcsx2

    # -- basic desktop utilities
    eog
    gedit

    prismlauncher
    onlyoffice-desktopeditors
    qbittorrent
    baobab
    inkscape
    rawtherapee
    legendary-gl
  ];
}
