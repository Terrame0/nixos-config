{pkgs, ...}: {
  home.packages = with pkgs; [
    # -- dev tools
    python3
    nixd
    jq-lsp
    jq
    gtk3.dev

    # -- utilities
    treefmt
    brightnessctl
    wireplumber
    alejandra
    any-nix-shell
    fastfetch
    tree
    jq
    ouch
    htop

    # -- screenshotse
    grim
    slurp

    # -- shell clipboard broker
    wl-clipboard
  ];
}
