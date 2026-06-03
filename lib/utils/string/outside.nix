{
  lib,
  extend-config,
  config,
  ...
}:
extend-config "string" {
  outside = start: end: string: let
    insides = config.string.between start end string;
  in
    lib.foldl (
      changing-string: snippet:
        lib.replaceStrings ["${start}${snippet}${end}"] [""] changing-string
    )
    string
    insides;
}
