{
  pkgs,
  config-add,
  config,
  ...
}:
config-add "convert"
{
  scss = file-data: let
    store-path = pkgs.runCommand (config.file.path-str file-data) {
      buildInputs = [pkgs.dart-sass];
    } "sass ${file-data.store-path} $out --no-source-map";
  in
    file-data
    // {
      inherit store-path;
      extension = "css";
    };
}
