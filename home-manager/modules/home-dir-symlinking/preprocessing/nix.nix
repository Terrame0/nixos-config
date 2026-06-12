{
  extend-config,
  config,
  lib,
  config-root,
  ...
}:
extend-config "convert"
{
  nix = file: let
    generator = lib.head (config.file.get-spec-values "form" file);
    generator-function = lib.generators.${"to" + (lib.toUpper generator)} {};
    contents =
      config.string.evaluate-nix
      (config.file.read file)
      {file-dir = lib.concatStringsSep "/" ([config-root] ++ file.dir-raw);};
  in
    config.file.emplace (file // {extension = generator;}) (generator-function contents);
}
