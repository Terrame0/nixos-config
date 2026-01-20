{
  pkgs,
  nixos-update-script,
  ...
}: {
  environment.systemPackages = with pkgs; [
    keyd
    nix-ld
    pacproxy
    nixos-update-script.packages.${pkgs.system}.default

    # -- gtk themes
    gnome-themes-extra
    adwaita-icon-theme
  ];
}
