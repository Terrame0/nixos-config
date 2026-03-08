{
  pkgs,
  extend-config,
  config,
  flake-root,
  ...
}:
extend-config "convert"
{
  scss = file-data: let
    store-path = pkgs.runCommand (config.file.path-str file-data) {
      buildInputs = [pkgs.dart-sass];
      root = flake-root + "/home-dir";
    } "sass ${file-data.store-path} $out --no-source-map --load-path $root";
  in
    file-data
    // {
      inherit store-path;
      extension = "css";
    };
}
