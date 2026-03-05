{
  lib,
  extend-config,
  ...
}:
extend-config "attrset" {
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
