{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    git
    alejandra
    nix-ld
    python3
    v2rayn
    xray
    modrinth-app
  ];
}
