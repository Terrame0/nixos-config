{
  lib,
  extend-config,
  ...
}:
extend-config "string" {
  between = start: end: string: let
    string-split = lib.splitString start string;

    parts-split = lib.forEach (lib.tail string-split) (
      part: let
        part-split = lib.splitString end part;
        inside = lib.head part-split;
      in
        if inside != ""
        then inside
        else null
    );
  in
    parts-split;
}
