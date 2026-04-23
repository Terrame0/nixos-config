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
      buildInputs = [pkgs.sassc];
    } "sassc ${file-data.store-path} $out";
  in
    file-data
    // {
      inherit store-path;
      extension = "css";
    };
}
