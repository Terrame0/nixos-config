{pkgs, ...}: {
  # -- user packages
  home.packages = with pkgs; [
    # -- dev/cli tools
    clang
    nixd
    clang-tools
    uv
    neofetch

    # -- desktop apps
    kdePackages.kdenlive
    telegram-desktop
    firefox
    vscode-fhs
  ];
}
