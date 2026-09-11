{pkgs, ...}: {
  home.packages = with pkgs; [
    # -- lsps
    nixd
    jq-lsp

    # -- dev tools
    python3
    gtk3.dev
    jq

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
