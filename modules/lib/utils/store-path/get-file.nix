{
  lib,
  extend-config,
  config,
  ...
}:
extend-config "store-path" {
  get-file = store-path: let
    path-str = builtins.unsafeDiscardStringContext (toString store-path);
    raw-path-parts = lib.splitString "/" (lib.removePrefix (toString builtins.storeDir) path-str);
    specs =
      config.list.indexed-foldl (
        accumulated-spec-list: dir: i:
          accumulated-spec-list
          ++ lib.forEach (config.string.between "[" "]" dir) (
            spec: (config.string.split-to-attrs ":" spec) // {index = i;}
          )
      ) []
      raw-path-parts;
    path-parts = lib.forEach raw-path-parts (
      dir:
        config.string.outside "[" "]" dir
    );
    dir = lib.drop 2 (lib.init path-parts);
    name-parts = lib.splitString "." (lib.last path-parts);
    name = lib.concatStringsSep "." (config.list.inclusive-init name-parts);
    stem = config.string.outside "[" "]" name;

    extension =
      if lib.length name-parts != 1
      then lib.last name-parts
      else "";
  in {
    inherit store-path;
    dir = dir;
    inherit stem;
    asdfg = "";
    specs = specs;
    inherit extension;
  };
}
