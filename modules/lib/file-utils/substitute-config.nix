{
  lib,
  config-add,
  config,
  pkgs,
  ...
}:
config-add "file" {
  substitute-config = file-data: let
    file-contents = builtins.readFile file-data.store-path;
    new-store-path = pkgs.writeText (config.path.join file-data) (config.string.substitute-config file-contents);
  in
    file-data // {store-path = new-store-path;};
}
