{pkgs, ...}: {
  home.packages = with pkgs; [
    # -- dev/cli tools
    python3
    nixd
    neofetch
    git
    alejandra
    sops
    age
    tree
    any-nix-shell

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
