{pkgs, ...}: let
  unstable = import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
  }) {};
  myOverlay = self: super: {
    discordo = unstable.discordo;
  };
in {
  nixpkgs.overlays = [myOverlay];
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
    discordo

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
