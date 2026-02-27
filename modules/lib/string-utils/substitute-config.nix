{
  lib,
  config-add,
  config,
  ...
}:
config-add "string" {
  substitute-config = string: let
    begin = "\"@[";
    end = "]\"";
    substitutions = lib.traceValSeq (config.string.between begin end string);
    modified-string =
      lib.foldl (
        changing-string: substitution: let
          target = "${begin}${substitution}${end}";
          source = config.attrset.access config substitution;
        in
          lib.replaceStrings [target] [source] changing-string
      )
      string
      substitutions;
  in
    modified-string;
}
