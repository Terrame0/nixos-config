{
  config,
  config-add,
  lib,
  ...
}:
config-add "file" {
  resolve-home-entry = file-data: let
    file-resolved = config.file.modify file-data config.string.substitute-expressions;
    file-converted =
      if file-resolved.extension == "scss"
      then config.convert.scss file-resolved
      else if file-resolved.extension == "nix"
      then config.convert.nix file-resolved
      else file-resolved;
  in
    file-converted;
}
