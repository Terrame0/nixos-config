{pkgs, ...}: {
  home.packages = with pkgs; [
    # -- lsps
    nixd
    jq-lsp

    # -- dev tools
    python3
    # clang-tools
    gtk3.dev
    jq

    # -- utilities
    treefmt
    alejandra
    any-nix-shell
    fastfetch
    tree
    ouch
    htop
  ];
}
