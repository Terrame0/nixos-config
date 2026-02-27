{
  config-add,
  config,
  pkgs,
  ...
}:
config-add "file" {
  substitute-config = file-data: let
    new-file-data = config.file.make-copy file-data (config.string.substitute-config (config.file.read-file file-data));
  in
    file-data // {store-path = new-file-data ;};
}
