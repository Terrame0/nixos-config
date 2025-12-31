{pkgs, ...}: {
  # -- user packages
  home.packages = with pkgs; [
    # -- dev/cli tools
    clang
    nixd
    clang-tools
    uv
    neofetch
    prismlauncher

    # -- desktop apps
    kdePackages.kdenlive
    telegram-desktop
    firefox
    libreoffice-fresh
    transmission_4
  ];
}
