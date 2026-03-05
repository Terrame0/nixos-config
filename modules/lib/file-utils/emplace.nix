{
  extend-config,
  config,
  ...
}:
extend-config "file" {
  emplace = file-data: contents:
    config.file.modify file-data (_: contents);
}
