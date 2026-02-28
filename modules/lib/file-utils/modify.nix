{
  config-add,
  config,
  lib,
  ...
}:
config-add "file" {
  modify = file-data: lambda: let
    contents = config.file.read file-data;
    file-data-new = config.file.make-new ((config.file.path-str file-data) + "-transformed") (lambda contents);
    store-path = file-data-new.store-path;
  in
    file-data // {inherit store-path;};
}
