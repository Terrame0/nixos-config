{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    alejandra
    nix-ld
    python3
    v2rayn
    xray
    nix-output-monitor
  ];
}
# sudo nixos-rebuild test --print-build-logs --verbose --log-format internal-json |& nom --json

