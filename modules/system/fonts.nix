{pkgs, ...}: {
  fonts.fontconfig.enable = true;
  fonts.packages = with pkgs; [
    times-newer-roman
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
  ];
}
