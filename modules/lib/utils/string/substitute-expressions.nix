{
  lib,
  extend-config,
  config,
  ...
}:
extend-config "string" {
  substitute-expressions = text: let
    interpolation-flags = {
      "" = string: args: string;
      "suf" = string: args: "${string}${lib.elemAt args 0}";
      "str" = string: args: "\"${string}\"";
    };

    apply-flags = flag-str: string: let
      flags = lib.splitString "/" flag-str;
    in
      lib.foldl (
        changing-string: flag: let
          flag-body = config.string.before "(" flag;
          flag-args = config.string.between "(" ")" flag;
        in
          interpolation-flags.${flag-body} changing-string flag-args
      )
      string
      flags;

    modified-string = let
      begin = "\"#[";
      end = "]\"";
      matched-strings = config.string.between begin end text;
    in
      lib.foldl (
        changing-text: matched-string: let
          can-interpolate = value: (builtins.tryEval (builtins.toString value)).success;
          substitution-target = "${begin}${matched-string}${end}";
          matched-string-parts = lib.splitString "|" matched-string;
          head = config.list.exclusive-head matched-string-parts;
          flag-str =
            if head != null
            then config.list.exclusive-head matched-string-parts
            else "";
          expression = lib.last matched-string-parts;
          evaluated-expression = config.string.evaluate-nix "{config,lib,pkgs,home-root,host,username}:${expression}";
        in
          assert can-interpolate evaluated-expression;
            lib.replaceStrings [substitution-target] [(apply-flags flag-str (builtins.toString evaluated-expression))] changing-text
      )
      text
      matched-strings;
  in
    modified-string;
}
