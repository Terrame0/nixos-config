{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    keyd
    nix-ld
    pacproxy
    inputs.nixos-update-script.packages.${pkgs.system}.default
  ];

  # -- remove preinstalled apps
  documentation.nixos.enable = false;
  services.xserver.excludePackages = [pkgs.xterm];
}
