{
  pkgs,
  nixos-update-script,
  ...
}: {
  environment.systemPackages = with pkgs; [
    keyd
    git
    alejandra
    nix-ld
    v2rayn
    nix-output-monitor
    nixos-update-script.packages.${pkgs.system}.default
  ];
}
