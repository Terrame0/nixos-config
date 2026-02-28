{
  lib,
  config-add,
  ...
}:
config-add "attrset" {
  access = attrset: key-string: let
    result =
      lib.foldl (
        level: key: level.${key}
      )
      attrset
      (lib.splitString "." key-string);
  in
    result;
}
