{pkgs, ...}: {
  home.packages = with pkgs; [
    # -- dev tools
    python3
    nixd
    git

    # -- encryption
    sops
    age

    # -- misc cli tools
    any-nix-shell
    brightnessctl
    wireplumber
    alejandra
    neofetch
    tree
    jq

    # -- windows compatibility layer
    wineWowPackages.full
    winetricks
    dxvk

    # -- basic desktop utilities
    nemo
    mpv
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
    blender
    gimp
  ];
}
