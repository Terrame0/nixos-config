{
  config,
  config-add,
  lib,
  ...
}:
config-add "file" {
  resolve-home-entry = original-file-data: let
    file-data = config.file.substitute-config original-file-data;
    new-file-data =
      if file-data.extension == "scss"
      then config.convert.scss file-data
      else if file-data.extension == "nix"
      then config.convert.nix file-data (lib.elemAt file-data.specs 0) (lib.elemAt file-data.specs 1)
      else file-data;
  in
    new-file-data;
}
