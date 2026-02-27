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
    new-file-data = file-data // {extension = extension;};
    file-path = config.path.join new-file-data;
    generator-function = lib.generators.${"to" + (lib.toUpper generator)} {};
    new-store-path = pkgs.writeText file-path (generator-function (import new-file-data.store-path {
      inherit config;
      inherit lib;
      inherit pkgs;
    }));
  in
    new-file-data // {store-path = new-store-path;};
}
