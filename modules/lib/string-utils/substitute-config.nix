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
          substitution-split = lib.splitString "|" substitution;
          config-attribute = config.attrset.access config (lib.head substitution-split);

          change =
            if (lib.length substitution-split) != 1
            then
              lib.foldl (
                function: parameter:
                  function parameter
              )
              config-attribute
              (lib.tail substitution-split)
            else config-attribute;
        in
          lib.replaceStrings [target] [change] changing-string
      )
      string
      substitutions;
  in
    modified-string;
}
