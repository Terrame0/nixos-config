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
    spec-list = config.string.between "[" "]" (lib.concatStrings path-parts);
    specs =
      lib.foldl (
        spec-attrs-list: spec:
          spec-attrs-list ++ [(config.string.split-to-attrs ":" spec)]
      ) []
      spec-list;
    extension =
      if lib.length name-parts != 1
      then lib.last name-parts
      else "";
  in {
    inherit store-path;
    inherit dir;
    inherit stem;
    inherit specs;
    inherit extension;
  };
}
