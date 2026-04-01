{
  extend-config,
  config,
  lib,
  flake-root,
  ...
}:
extend-config "convert"
{
  nix = file: let
    generator = lib.head (config.file.get-spec-values "to" file);
    generator-function = lib.generators.${"to" + (lib.toUpper generator)} {};
    contents =
      config.string.evaluate-nix
      (config.file.read file)
      {file-dir = lib.concatStringsSep "/" ([flake-root] ++ file.dir-raw);};
  in
    (config.file.emplace file (generator-function contents)) // {extension = generator;};
}
