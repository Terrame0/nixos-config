{
  pkgs,
  config-add,
  config,
  lib,
  ...
}:
config-add "convert"
{
  nix = file-data: generator: extension: let
    file-data-new = file-data // {extension = extension;};
    file-path = config.path.join-str file-data-new;
    generator-function = lib.generators.${"to" + (lib.toUpper generator)} {};
    new-store-path = pkgs.writeText file-path (generator-function (import file-data-new.store-path {
      inherit config;
      inherit lib;
      inherit pkgs;
    }));
  in
    file-data-new // {store-path = new-store-path;};
}
