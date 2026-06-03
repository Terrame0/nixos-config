{
  extend-config,
  config,
  ...
}:
extend-config "file" {
  emplace = file: contents:
    config.file.modify file (_: contents);
}
