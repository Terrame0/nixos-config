{
  inputs,
  pkgs,
  sundry,
  lib,
  osConfig,
  ...
}: let
  paths = map (package: "${package}/share/fonts") osConfig.fonts.packages;
  dir = pkgs.nuenv.mkDerivation {
    name = "flat-fonts";
    src = pkgs.symlinkJoin {
      name = "fonts";
      inherit paths;
    };
    build =
      /**/
      ''
        mkdir $env.out
        let files = glob $"($env.src)/**/*" --no-dir
        for f in $files {
          let filename = $f | path split | skip 1 | str join "-"
          cp $f $"($env.out)/($filename)"
        }
      '';
  };
in {
  # -- needed for onlyoffice to pick up fonts
  home.file.".local/share/fonts".source = dir; #"${inputs.microsoft-fonts.packages.${pkgs.stdenv.hostPlatform.system}.ttf-ms-win11-auto}/share/fonts";
}
