{
  config,
  config-add,
  lib,
  ...
}:
config-add "resolve-home-file" (
  file-data-in: let
    bruh = config.string.substitute "\"@[adsfasdf]\"";
    out-data =
      if file-data-in.extension == "scss"
      then config.convert.scss file-data-in
      else if file-data-in.extension == "nix"
      then config.convert.nix file-data-in (lib.elemAt file-data-in.specs 0) (lib.elemAt file-data-in.specs 1)
      else file-data-in;
  in
    out-data
)
