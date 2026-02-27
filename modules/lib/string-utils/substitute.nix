{
  lib,
  config-add,
  config,
  ...
}:
config-add "string" {
  substitute = string: let
    begin = "\"@[";
    end = "]\"";
    substitutions = config.string.between begin end string;
    modified-string =
      lib.foldl (
        changing-string: substitution: let
          full-char-sequence = "${begin}${substitution}${end}";
          a = lib.traceValSeq (config.attribute.access config substitution);
        in
          lib.replaceStrings [full-char-sequence] [a]
          changing-string
      )
      string
      substitutions;
  in
    modified-string;
}
