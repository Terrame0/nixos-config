{
  config,
  config-add,
  ...
}:
config-add "fns" {
  convert-home-file = file-data: let
    out-data =
      if file-data.extension == "scss"
      then (config.fns.compile-scss file-data) // file-data
      else file-data;
  in
    out-data;
}
