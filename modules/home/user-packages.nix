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
    xarchiver
    neofetch
    tree
    jq

    # -- games
    wineWowPackages.stable
    vulkan-loader
    vulkan-tools
    dxvk
    vkd3d
    winetricks
    lutris
    pcsx2

    # -- basic desktop utilities
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
