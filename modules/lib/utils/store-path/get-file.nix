{
  lib,
  extend-config,
  config,
  ...
}:
extend-config "store-path" {
  get-file = store-path: let
    raw-path-str = builtins.unsafeDiscardStringContext (toString store-path);
    raw-path-trimmed = lib.removePrefix (toString builtins.storeDir + "/") raw-path-str;
    raw-path-parts = lib.drop 1 (lib.splitString "/" raw-path-trimmed);
    file-data =
      if raw-path-parts != []
      then let
        path-parts = lib.forEach raw-path-parts (
          dir:
            config.string.outside "[" "]" dir
        );
        specs =
          config.list.indexed-foldl (
            accumulated-spec-list: dir: i:
              accumulated-spec-list
              ++ lib.forEach (config.string.between "[" "]" dir) (
                spec: (config.string.split-to-attrs ":" spec) // {index = i;}
              )
          ) []
          raw-path-parts;
        dir = lib.init path-parts;
        dir-raw = lib.init raw-path-parts;
        name-parts = lib.splitString "." (lib.last path-parts);
        name = lib.concatStringsSep "." (config.list.inclusive-init name-parts);
        stem = config.string.outside "[" "]" name;
        extension =
          if lib.length name-parts != 1
          then lib.last name-parts
          else "";
      in {
        inherit dir;
        inherit dir-raw;
        inherit stem;
        inherit specs;
        inherit extension;
        bruh = config.file.make-tree "test" [
          {
            path = "/a/b/c/bruh.txt";
            contents = "something written in text";
          }
          {
            path = "/a/b/c/asdbruh.txt";
            contents = "something written in text";
          }
        ];
      }
      else {};
  in
    {inherit store-path;} // file-data;
}
