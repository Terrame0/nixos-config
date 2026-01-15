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
    gparted
    wireshark
    dconf-editor
    prismlauncher
    kdePackages.kdenlive
    telegram-desktop
    firefox # -- TODO: CONFIGURE IN HOME MANAGER
    libreoffice-fresh
    qbittorrent
    blender
    gimp
  ];
}
