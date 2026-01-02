{pkgs, ...}: {
  # -- user packages
  home.packages = with pkgs; [
    # -- dev/cli tools
    clang
    nixd
    clang-tools
    neofetch

    # -- desktop apps
    prismlauncher
    kdePackages.kdenlive
    telegram-desktop
    firefox
    vivaldi
    libreoffice-fresh
    qbittorrent
    blender
    gimp
  ];
}
