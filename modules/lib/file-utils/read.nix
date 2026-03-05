{extend-config, ...}:
extend-config "file" {
  read = file-data: let
  in
    builtins.readFile file-data.store-path;
}
