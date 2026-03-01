{config-add, ...}:
config-add "file" {
  read = file-data: let
  in
    builtins.readFile file-data.store-path;
}
