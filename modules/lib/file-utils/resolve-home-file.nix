{
  config,
  config-add,
  lib,
  ...
}:
config-add "file" {
  resolve-home-entry = file-data-original: let
    file-data = config.file.substitute-config file-data-original;
    file-data-new =
      if file-data.extension == "scss"
      then config.convert.scss file-data
      else if file-data.extension == "nix"
      then config.convert.nix file-data (lib.elemAt file-data.specs 0) (lib.elemAt file-data.specs 1)
      else file-data;
  in
    file-data-new;
}
