{
  config-add,
  config,
  ...
}:
config-add "file" {
  emplace = file-data: contents:
    config.file.modify file-data (_: contents);
}
