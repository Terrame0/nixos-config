{
  config-add,
  config,
  pkgs,
  ...
}:
config-add "path" {
  make-file = store-path: contents: let
    file-path-str = config.path.join-str (config.path.get-data store-path);
  in
    config.path.get-data (pkgs.writeText file-path-str contents);
}
