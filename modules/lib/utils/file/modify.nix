{
  extend-config,
  config,
  ...
}:
extend-config "file" {
  modify = file: lambda: let
    contents = config.file.read file;
    file-new = config.file.mk-new ((config.file.path-str file) + "-transformed") (lambda contents);
    store-path = file-new.store-path;
  in
    file // {inherit store-path;};
}
