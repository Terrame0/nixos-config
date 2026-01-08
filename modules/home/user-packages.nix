{pkgs, ...}: {
  # -- user packages
  home.packages = with pkgs; [
    # -- dev/cli tools
    python3
    clang
    nixd
    clang-tools
    neofetch
    zsh-powerlevel10k

    # -- desktop apps
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
