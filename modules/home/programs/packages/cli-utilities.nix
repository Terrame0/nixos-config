{pkgs, ...}: {
  home.packages = with pkgs; [
    # -- dev tools
    (python3.withPackages (pkg-set: [pkg-set.tkinter]))
    git
    nixd
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
