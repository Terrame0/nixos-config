{
  pkgs,
  extend-config,
  lib,
  ...
}:
extend-config "convert"
{
  scss = file: include-paths: staging-dir: let
    modifications = let
      include-flags = lib.forEach (include-paths.sass or []) (path: "--load-path='${staging-dir}/${path}'");
    in {
      extension = "css";
      store-path = pkgs.runCommand (file.stem + ".css") {
        buildInputs = [pkgs.dart-sass];
      } "sass ${file.store-path} $out --no-source-map --load-path='${staging-dir}' ${lib.concatStringsSep " " include-flags} --quiet";
    };
  in
    file // modifications;
}
