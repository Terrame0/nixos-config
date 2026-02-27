{
  lib,
  config-add,
  ...
}:
config-add "attribute" {
  access = attrset: keys: let
    result =
      lib.foldl (
        level: key: level.${key}
      )
      attrset
      keys;
  in
    result;
}
