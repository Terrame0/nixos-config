{
  pkgs,
  inputs,
  ...
}: {
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs;
    with inputs.microsoft-fonts.packages.${pkgs.system}; [
      monocraft
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      ttf-ms-win11-auto
    ];
  };
}
