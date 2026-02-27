{
  config,
  config-add,
  ...
}:
config-add "resolve-home-file" (
  file-data-in: let
    out-data =
      if file-data-in.extension == "scss"
      then config.convert.scss file-data-in
      else if file-data-in.extension == "nix"
      then config.convert.nix file-data-in "json" ""
      else file-data-in;
  in
    out-data
)
