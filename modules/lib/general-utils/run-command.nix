{
  extend-config,
  config,
  pkgs,
  ...
}:
extend-config "run-command" (
  command:
    config.file.read (config.store-path.get-file-data (pkgs.runCommand "my-command" {} "${command} > $out"))
)
