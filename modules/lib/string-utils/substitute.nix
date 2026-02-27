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
        in
          lib.replaceStrings [full-char-sequence] [config.attribute.access config substitution]
          changing-string
      )
      string
      substitutions;
  in
    modified-string;
}
