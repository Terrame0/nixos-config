{
  pkgs,
  config-add,
  config,
  lib,
  ...
}:
config-add "convert"
{
  nix = file-data-in: generator: extension: let
    file-data = file-data-in // {extension = extension;};
    file-path = config.path.join file-data;
    generator-function = lib.generators.${"to"+ (lib.toUpper generator)} {};
    store-path = pkgs.writeText file-path (generator-function (import file-data.store-path {inherit config; inherit lib; inherit pkgs;}));
  in
    file-data
    // {
      store-path = store-path;
    };
}
