{pkgs, ...}: {
  home.packages = with pkgs; [
    # -- lsps
    nixd
    jq-lsp

    # -- dev tools
    python3
    clang-tools
    gtk3.dev
    jq

    # -- utilities
    treefmt
    brightnessctl
    wireplumber
    alejandra
    fastfetch
    tree
    ouch
    htop

    # -- screenshots
    grim
    slurp

    # -- shell clipboard broker
    wl-clipboard
  ];
}
