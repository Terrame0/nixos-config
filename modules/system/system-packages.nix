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

    steam-run
    lib32.glibc
    lib32.gcc
    lib32.mesa
    lib32.vulkan-loader
    lib32.vulkan-tools
  ];

  # -- remove preinstalled apps
  documentation.nixos.enable = false;
  services.xserver.excludePackages = [pkgs.xterm];
}
