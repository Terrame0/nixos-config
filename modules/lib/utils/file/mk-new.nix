{
  extend-config,
  config,
  pkgs,
  ...
}:
extend-config "file" {
  mk-new = file-path-str: contents:
    config.store-path.get-file (pkgs.writeText file-path-str contents);
}
