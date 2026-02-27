{
  config-add,
  config,
  ...
}:
config-add "file" {
  substitute-config = file-data:
    config.file.edit file-data config.string.substitute-config;
}
