{
  lib,
  extend-config,
  ...
}:
extend-config "string" {
  before = sep: string:
    lib.head (lib.splitString sep string);
}
