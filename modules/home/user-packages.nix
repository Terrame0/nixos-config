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

    # -- hyprland
    # waybar
    # hyprpaper
    # wl-clipboard
    # mako
    # pamixer
    # xdg-desktop-portal

    # -- desktop apps
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
