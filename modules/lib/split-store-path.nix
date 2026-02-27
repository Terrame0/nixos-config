{
  lib,
  config-add,
  ...
}:
config-add "fns" {
  split-store-path = store-path: let
    path-str = lib.traceValSeq (toString store-path);
    full-path-split = lib.traceValSeq (lib.splitString "/" path-str);
    dir = lib.traceValSeq (lib.drop 4 (lib.init full-path-split));
    split-name = lib.traceValSeq (lib.splitString "." (lib.last full-path-split));
    name = lib.traceVal (lib.concatStringsSep "." (
      if (lib.length split-name) != 1
      then lib.init split-name
      else split-name
    ));
  in
    {
      inherit store-path;
      inherit dir;
      inherit name;
    }
    // lib.optionalAttrs ((lib.length split-name) != 1 && (lib.head split-name) != "") {
      extension = lib.last split-name;
    };
}
