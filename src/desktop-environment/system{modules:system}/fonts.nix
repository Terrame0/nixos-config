{
  pkgs,
  inputs,
  username,
  ...
}: {
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs;
    with inputs.microsoft-fonts.packages.${pkgs.stdenv.hostPlatform.system}; [
      monocraft
      nerd-fonts.jetbrains-mono
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      ttf-ms-win11-auto
    ];
  };

  home-manager.users.${username}.home.file.".local/share/fonts".source = "${inputs.microsoft-fonts.packages.${pkgs.stdenv.hostPlatform.system}.ttf-ms-win11-auto}/share/fonts";
}
