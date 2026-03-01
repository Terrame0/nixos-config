{
  config-add,
  config,
  pkgs,
  ...
}:
config-add "run-command" (
  command:
    config.file.read (config.store-path.get-file-data (pkgs.runCommand "my-command" {} "${command} > $out"))
)
