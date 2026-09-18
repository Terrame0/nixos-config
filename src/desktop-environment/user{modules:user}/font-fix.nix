{
  inputs,
  pkgs,
  sundry,
  lib,
  osConfig,
  ...
}: {
  # -- needed for onlyoffice to pick up fonts
  home.file.".local/share/fonts".source = pkgs.nuenv.mkDerivation {
    name = "flat-fonts";
    src = pkgs.symlinkJoin {
      name = "fonts";
      paths = map (package: "${package}/share/fonts") osConfig.fonts.packages;
    };
    build =
      # -< nushell >-
      ''
        mkdir $env.out
        let files = glob $"($env.src)/**/*" --no-dir
        for f in $files {
          let filename = $f | path split | skip 1 | str join "-"
          cp $f $"($env.out)/($filename)"
        }
      '';
  };
}
