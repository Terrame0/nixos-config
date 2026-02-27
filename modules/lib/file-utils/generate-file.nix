{
  config-add,
  config,
  pkgs,
  ...
}:
let 
  generate-file = store-path: contents: let
    file-path = config.path.join (config.file.get-data store-path);
    file-data = config.file.get-data (pkgs.writeText file-path contents);
  in
    file-data;
in
  config-add "file" {
  make-new = store-path: generate-file store-path;
  make-copy = file-data: generate-file file-data.store-path;
}
