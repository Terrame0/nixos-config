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

    # -- just to be sure
    SDL2
    lib32.SDL2
    libGL
    mesa.drivers

    # -- libs for wine
    lib32-glibc
    lib32-libxcb
    lib32-gnutls
    lib32-libpulseaudio
    lib32-alsa-lib
    lib32-ocl-icd

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
