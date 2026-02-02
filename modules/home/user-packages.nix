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
    brightnessctl
    jq

    # -- desktop apps
    whatsapp-electron
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
