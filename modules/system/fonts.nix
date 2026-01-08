{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    corefonts
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}
