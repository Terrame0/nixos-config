{
  lib,
  extend-config,
  ...
}:
extend-config "string" {
  after = sep: string:
    lib.concatStrings (lib.tail (lib.splitString sep string));
}
