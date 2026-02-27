{
  lib,
  config-add,
  ...
}:
config-add "attribute" {
  access = attrset: keys: lib.foldl (level: key: level.${key}) attrset keys;
}
