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
    throne
  ];

  # -- remove preinstalled apps
  documentation.nixos.enable = false;
  services.xserver.excludePackages = [pkgs.xterm];
}
