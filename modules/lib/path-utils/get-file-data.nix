{
  lib,
  config-add,
  config,
  ...
}:
config-add "store-path" {
  get-file-data = store-path: let
    path-str = toString store-path;
    path-split = lib.splitString "/" (lib.removePrefix (toString builtins.storeDir) path-str);
    dir = lib.drop 2 (lib.init path-split);
    name-split = lib.splitString "." (lib.last path-split);
    name = lib.concatStringsSep "." (
      config.list.inclusive-init name-split
    );
    stem = lib.head (lib.splitString "{" name);
    specs = config.string.between "{" "}" name;
    extension = config.list.exclusive-last name-split;
  in {
    inherit store-path;
    inherit dir;
    inherit stem;
    inherit specs;
    inherit extension;
  };
}
