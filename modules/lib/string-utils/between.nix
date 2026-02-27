{
  lib,
  config-add,
  ...
}:
config-add "string" {
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
    lib.traceValSeq (
      if parts-split != []
      then parts-split
      else null
    );
}
