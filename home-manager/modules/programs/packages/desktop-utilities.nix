{pkgs, ...}: {
  home.packages = with pkgs; [
    # -- games
    lutris
    wine-wayland
    winetricks
    pcsx2

    # -- basic desktop utilities
    eog
    gedit

    # -- desktop apps
    # whatsapp-electron
    # telegram-desktop
    # freecad
    # gparted
    # dconf-editor
    prismlauncher
    onlyoffice-desktopeditors
    qbittorrent
    # transmission_4-gtk
    # blender
    # gimp
    baobab
    inkscape
    rawtherapee
  ];
}
