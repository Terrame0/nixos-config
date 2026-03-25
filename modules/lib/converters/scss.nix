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
  scss = file: let
    modifications = {
      store-path = pkgs.runCommand (config.file.path-str file) {
        buildInputs = [pkgs.dart-sass];
        root = flake-root + "/" + lib.head file.dir;
      } "sass ${file.store-path} $out --no-source-map --load-path $root --quiet";
      extension = "css";
    };
  in
    file // modifications;
}
