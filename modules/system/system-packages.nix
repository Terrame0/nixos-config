{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    keyd
    git
    alejandra
    nix-ld
    v2rayn
    nix-output-monitor
  ];
}
