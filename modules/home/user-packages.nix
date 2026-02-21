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
    wineWowPackages.stagingFull
    winetricks
    vulkan-loader
    vulkan-tools
    mesa-demos
    dxvk
    vkd3d
    pcsx2
    mesa

    # -- just to be sure
    SDL2
    sdl3
    sdl3-image
    sdl3-ttf

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
