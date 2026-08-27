{pkgs, ...}: {
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      monocraft
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
    ];
  };
}
