{
  lib,
  mk-type,
  ...
}: {
  font-family = mk-type {
    name = "font-family";
    value-check = value:
      lib.isString value
      && value != ""
      && !lib.any
      ((lib.flip lib.hasInfix) value)
      ["\"" "\\" "\n" "\r"];
    rendered-values = value: {
      scss = "\"${value}\"";
      qml = "\"${value}\"";
      lua = "\"${value}\"";
      rasi = "\"${value}\"";
    };
  };
}
