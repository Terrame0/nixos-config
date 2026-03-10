{extend-config, ...}:
extend-config "file" {
  read = file: let
  in
    builtins.readFile file.store-path;
}
