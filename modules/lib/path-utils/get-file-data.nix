{
  lib,
  extend-config,
  config,
  ...
}:
extend-config "store-path" {
  get-file-data = store-path: let
    path-str = toString store-path;
    path-parts = lib.splitString "/" (lib.removePrefix (toString builtins.storeDir) path-str);
    dir = lib.drop 2 (lib.init path-parts);
    name-parts = lib.splitString "." (lib.last path-parts);
    name = lib.concatStringsSep "." (
      config.list.inclusive-init name-parts
    );
    stem = config.string.before "[" name;
    spec-list = config.debug (config.string.between "[" "]" name);
    specs =
      lib.foldl (
        spec-attrs-list: spec:
          spec-attrs-list ++ [(config.string.split-to-attrs ":" spec)]
      ) []
      spec-list;
    extension = config.list.exclusive-last name-parts;
  in {
    inherit store-path;
    inherit dir;
    inherit stem;
    specs = config.debug spec-list;
    new-specs = config.debug specs;
    inherit extension;
  };
}
