{
  extend-config,
  config,
  lib,
  ...
}:
extend-config "convert"
{
  nix = file: let
    generator = lib.head (config.file.get-specs "to" file);
    generator-function = lib.generators.${"to" + (lib.toUpper generator)} {};
    contents = config.string.evaluate-nix (config.file.read file);
  in (config.file.emplace file (generator-function contents));
}
