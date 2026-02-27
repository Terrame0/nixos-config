{
  lib,
  config-add,
  config,
  pkgs,
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
          substitution-split = lib.splitString "|" substitution;
          config-attribute = config.attrset.access config (lib.head substitution-split);
          module = pkgs.makeFile substitution "{lib,config,pkgs}:${substitution}";
        in
          lib.replaceStrings [target] [config-attribute] changing-string
      )
      string
      substitutions;
  in
    modified-string;
}
