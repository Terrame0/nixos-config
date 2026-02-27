{
  config-add,
  config,
  ...
}:
config-add "file" {
  edit = file-data: lambda: let
    contents = config.file.read file-data;
    edited-file-data = config.path.make-file file-data.store-path (lambda contents);
  in
    file-data // {store-path = edited-file-data.store-path;};
}
