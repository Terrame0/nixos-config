{pkgs, ...}: {
  home.packages = with pkgs; [
    # -- lsps
    nixd
    jq-lsp

    # -- dev tools
    python3
    gtk3.dev
    jq
    nasm

    # -- utilities
    treefmt
    alejandra
    fastfetch
    tree
    delta
    ouch
    htop
    tokei
    pwgen
  ];
}
