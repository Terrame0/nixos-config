{
  extend-config,
  config,
  lib,
  ...
}:
extend-config "convert"
{
  nix = file-data: let
    file-specs = file-data.new-specs;
    generator = (lib.findFirst (x: x.name == "to") null file-specs).value;
    generator-function = lib.generators.${"to" + (lib.toUpper generator)} {};
    contents = config.string.evaluate-nix (config.file.read file-data);
  in (config.file.emplace file-data (generator-function contents));
}
