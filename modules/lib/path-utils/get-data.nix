{
  lib,
  config-add,
  config,
  ...
}:
config-add "path" {
  get-data = store-path: let
    path-str = toString store-path;
    full-path-split = lib.splitString "/" path-str;
    dir = lib.drop 4 (lib.init full-path-split);
    name-split = lib.splitString "." (lib.last full-path-split);
    name = lib.concatStringsSep "." (
      config.lists.inclusive-init name-split
    );
    stem = lib.head (lib.splitString "{" name);
    specs = config.strings.between "{" "}" name;
    extension = config.lists.exclusive-last name-split;
  in {
    bruh = config.string.substitute "\"@[adsfasdf]\"";
    inherit store-path;
    inherit dir;
    inherit stem;
    inherit specs;
    inherit extension;
  };
}
