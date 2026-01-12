{pkgs, ...}: {
  # -- user packages
  home.packages = with pkgs; [
    # -- dev/cli tools
    python3
    clang
    nixd
    clang-tools
    neofetch

    # -- misc
    libinput

    # -- desktop apps
    wireshark
    dconf-editor
    prismlauncher
    kdePackages.kdenlive
    telegram-desktop
    vivaldi
    libreoffice-fresh
    qbittorrent
    blender
    gimp
  ];
}
