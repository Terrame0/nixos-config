{
  extend-config,
  config,
  lib,
  ...
}:
extend-config "convert"
{
  nix = file: let
    file-specs = file.specs;
    generator = (lib.findFirst (x: x.name == "to") null file-specs).value;
    generator-function = lib.generators.${"to" + (lib.toUpper generator)} {};
    contents = config.string.evaluate-nix (config.file.read file);
  in (config.file.emplace file (generator-function contents));
}
