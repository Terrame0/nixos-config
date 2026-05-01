{pkgs, ...}: {
  home.packages = with pkgs; [
    # -- dev tools
    python3
    git
    nixd
    gtk3.dev

    # -- utilities
    brightnessctl
    wireplumber
    alejandra
    any-nix-shell
    fastfetch
    tree
    jq
    ouch
    htop

    # -- encryption
    sops
    age

    # -- screenshots
    grim
    slurp

    # -- shell clipboard broker
    wl-clipboard
  ];
}
