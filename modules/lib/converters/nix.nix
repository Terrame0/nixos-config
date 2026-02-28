{
  config-add,
  config,
  lib,
  ...
}:
config-add "convert"
{
  nix = file-data: let
    generator = lib.elemAt file-data.specs 0;
    extension = lib.elemAt file-data.specs 1;
    generator-function = lib.generators.${"to" + (lib.toUpper generator)} {};
    contents = config.debug (config.string.evaluate-nix (config.file.read file-data));
  in
    (config.file.emplace file-data (generator-function contents)) // {inherit extension;};
}
