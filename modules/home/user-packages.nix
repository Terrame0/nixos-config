{pkgs, ...}: {
  # -- user packages
  home.packages = with pkgs; [
    # -- dev/cli tools
    python3
    clang
    nixd
    clang-tools
    neofetch

    # -- desktop apps
    wireshark
    dconf-editor
    prismlauncher-unwrapped
    kdePackages.kdenlive
    telegram-desktop
    vivaldi
    libreoffice-fresh
    qbittorrent
    blender
    gimp
  ];
}
