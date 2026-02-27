{
  config-add,
  pkgs,
  ...
}:
config-add "file" {
  read-file = file-data: contents: let
  in 
    pkgs.readFile file-data.store-path;
}
