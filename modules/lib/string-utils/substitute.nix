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
        string: substitution: let
          full-char-sequence = "${begin}${substitution}${end}";
        in
          lib.replaceStrings [full-char-sequence] [config.${substitution}]
      )
      string
      substitutions;
  in
    modified-string;
}
