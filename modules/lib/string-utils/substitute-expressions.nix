{
  lib,
  config-add,
  config,
  ...
}:
config-add "string" {
  substitute-expressions = string: let
    begin = "\"@[";
    end = "]\"";
    substitutions = config.string.between begin end string;
    modified-string =
      lib.foldl (
        changing-string: expression: let
          target = "${begin}${expression}${end}";
          evaluated-expression = config.debug (config.string.evaluate-nix "{config,lib,pkgs}:${expression}");
          can-interpolate = val: (builtins.tryEval (builtins.toString val)).success;
        in
          assert can-interpolate evaluated-expression;
            lib.replaceStrings [target] [(builtins.toString evaluated-expression)] changing-string
      )
      string
      substitutions;
  in
    modified-string;
}
