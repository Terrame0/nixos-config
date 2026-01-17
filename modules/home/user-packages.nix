{pkgs, ...}: {
  # -- user packages
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

    # -- desktop apps
    discord
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
