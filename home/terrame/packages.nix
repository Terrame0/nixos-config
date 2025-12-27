{pkgs, ...}: {
  # -- user packages
  home.packages = with pkgs; [
    cowsay
  ];
}
