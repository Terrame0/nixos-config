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

    # -- needs no introduction
    wine

    # -- basic desktop utilities
    totem 
    xfce.thunar
    drawing
    eog
    gedit

    # -- desktop apps
    whatsapp-electron
    gparted
    dconf-editor
    prismlauncher
    telegram-desktop
    libreoffice-fresh
    qbittorrent
    blender
    gimp
  ];
}
