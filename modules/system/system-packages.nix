{pkgs, nixos-update, ...}: {
  environment.systemPackages = with pkgs; [
    keyd
    git
    alejandra
    nix-ld
    v2rayn
    nix-output-monitor
    nixos-update.packages.${pkgs.system}.nixos-update
  ];
}
