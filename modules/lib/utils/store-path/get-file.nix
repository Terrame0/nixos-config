{
  lib,
  extend-config,
  config,
  ...
}:
extend-config "store-path" {
  get-file = store-path: let
    path-str = builtins.unsafeDiscardStringContext (toString store-path);
    path-parts = lib.splitString "/" (lib.removePrefix (toString builtins.storeDir) path-str);
    dir = lib.drop 2 (lib.init path-parts);
    name-parts = lib.splitString "." (lib.last path-parts);
    name = lib.concatStringsSep "." (
      config.list.inclusive-init name-parts
    );
    stem = config.string.outside "[" "]" name;
    spec-list = config.string.between "[" "]" name;
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
    inherit specs;
    inherit extension;
  };
}
