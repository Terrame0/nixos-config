{
  lib,
  extend-config,
  ...
}:
extend-config "string" {
  between = start: end: string: let
    string-parts = lib.splitString start string;
    parts-split = lib.forEach (lib.tail string-parts) (
      part: let
        part-split = lib.splitString end part;
      in
        lib.head part-split
    );
  in
    parts-split;
}
