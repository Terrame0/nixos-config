{
  extend-config,
  config,
  ...
}:
extend-config "file" {
  modify = file: lambda: let
    contents = config.file.read file;
    file-new = config.file.mk-new (file.stem + "." + file.extension) (lambda contents);
    store-path = file-new.store-path;
  in
    file // {inherit store-path;};
}
