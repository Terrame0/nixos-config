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
    graphite-gtk-theme

    # -- desktop apps
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
