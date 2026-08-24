{
  lib,
  mk-type,
  ...
}: {
  font-family = mk-type {
    value-check = value:
      lib.isString value
      && value != ""
      && !lib.hasInfix "\"" value
      && !lib.hasInfix "\\" value
      && !lib.hasInfix "\n" value
      && !lib.hasInfix "\r" value;
    rendered-values = value: {
      scss = "\"${value}\"";
      qml = "\"${value}\"";
      lua = "\"${value}\"";
    };
  };
}
