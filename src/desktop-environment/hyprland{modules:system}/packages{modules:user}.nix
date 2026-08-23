{pkgs, ...}: {
  home.packages = with pkgs; [
    grim
    slurp
    brightnessctl
    playerctl
    wl-clipboard
  ];
}
