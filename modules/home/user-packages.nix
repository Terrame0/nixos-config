{pkgs, ...}: {
  home.packages = with pkgs; [
    # -- dev/cli tools
    python3
    clang
    nixd
    clang-tools
    neofetch
    git
    alejandra
    libinput
    sops
    age
    tree

    # -- desktop apps
    showtime
    loupe
    nautilus
    gnome-calculator
    gnome-text-editor
    gparted
    wireshark
    dconf-editor
    prismlauncher
    kdePackages.kdenlive
    telegram-desktop
    libreoffice-fresh
    qbittorrent
    blender
    gimp
  ];
}
