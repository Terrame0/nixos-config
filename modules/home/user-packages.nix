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
    lutris
    wineWowPackages.stable
    vulkan-loader
    vulkan-tools
    mesa-demos
    dxvk
    vkd3d
    winetricks
    gamemode
    gamescope
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
