{
  config-add,
  config,
  pkgs,
  ...
}:
config-add "file" {
  make-new = file-path-str: contents:
    config.store-path.get-file-data (pkgs.writeText file-path-str contents);
}
