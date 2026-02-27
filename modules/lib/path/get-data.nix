{
  lib,
  config-add,
  ...
}:
config-add "path" {
  get-data = store-path: let
    path-str = toString store-path;
    full-path-split = lib.splitString "/" path-str;
    dir = lib.drop 4 (lib.init full-path-split);
    split-name = lib.splitString "." (lib.last full-path-split);
    split-name-length = lib.length split-name;
    name = lib.concatStringsSep "." (
      if split-name-length != 1
      then lib.init split-name
      else split-name
    );
    extension = if split-name-length != 1
    then lib.last split-name
    else "";
  in
    {
      inherit store-path;
      inherit dir;
      inherit name;
      inherit extension;
    };
}
