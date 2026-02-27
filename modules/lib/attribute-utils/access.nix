{
  lib,
  config-add,
  ...
}:
config-add "attribute" {
  access = attrset: keys: let
    result =
      lib.foldl (
        level: key: lib.traceValSeq level.${key}
      )
      attrset
      keys;
  in
    result;
}
