{pkgs, ...}: {
  home.packages = with pkgs; [
    # -- dev tools
    python3
    nixd
    git

    # -- encryption
    sops
    age

    # -- cli tools
    any-nix-shell
    brightnessctl
    wireplumber
    alejandra
    neofetch
    dart-sass
    tree
    jq

    # -- gtk development
    gtk3.dev

    # -- screenshots
    grim
    slurp

    # -- shell clipboard broker
    wl-clipboard

    # -- games
    lutris
    wine-wayland
    winetricks
    pcsx2

    # -- basic desktop utilities
    xarchiver
    eog
    gedit

    # -- messenger clients
    whatsapp-electron
    telegram-desktop

    # -- desktop apps
    gparted
    dconf-editor
    prismlauncher
    libreoffice-fresh
    qbittorrent
    transmission_4-gtk
    blender
    gimp
  ];
}
