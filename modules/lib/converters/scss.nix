{
  pkgs,
  extend-config,
  config,
  flake-root,
  lib,
  ...
}:
extend-config "convert"
{
  scss = file: include-paths: let
    modifications = let
      include-flags = lib.forEach (include-paths.sass or []) (path: "--load-path='${flake-root}/${path}'");
    in {
      extension = "css";
      store-path = pkgs.runCommand (file.stem + ".css") {
        buildInputs = [pkgs.dart-sass];
        root = flake-root + "/" + lib.head file.dir;
      } "sass ${file.store-path} $out --no-source-map --load-path=$root ${lib.concatStringsSep " " include-flags} --quiet";
    };
  in
    file // modifications;
}
