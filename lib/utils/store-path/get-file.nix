{
  lib,
  extend-config,
  config,
  ...
}:
extend-config "store-path" {
  get-file = store-path: let
    strip-specs = str: config.string.outside "[" "]" str;
    raw-path-str = builtins.unsafeDiscardStringContext (toString store-path);
    raw-path-trimmed = lib.removePrefix (toString builtins.storeDir + "/") raw-path-str;
    raw-path-parts = lib.drop 1 (lib.splitString "/" raw-path-trimmed);
    file-data =
      if raw-path-parts != []
      then let
        specs =
          config.list.indexed-foldl (
            accumulated-spec-list: dir: i:
              accumulated-spec-list
              ++ lib.forEach (config.string.between "[" "]" dir) (
                spec: (config.string.split-to-attrs ":" spec) // {index = i;}
              )
          ) []
          raw-path-parts;
        dir-raw = lib.init raw-path-parts;
        dir = lib.forEach dir-raw strip-specs;
        raw-name-parts = lib.splitString "." (lib.last raw-path-parts);
        stem-raw = lib.concatStringsSep "." (config.list.inclusive-init raw-name-parts);
        stem = strip-specs stem-raw;
        extension =
          if lib.length raw-name-parts != 1
          then lib.last raw-name-parts
          else "";
      in {
        inherit dir;
        inherit dir-raw;
        inherit stem;
        inherit stem-raw;
        inherit specs;
        inherit extension;
      }
      else {};
  in
    {inherit store-path;} // file-data;
}
