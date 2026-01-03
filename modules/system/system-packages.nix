{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    alejandra
    nix-ld
    v2rayn
    nix-output-monitor
  ];
}
