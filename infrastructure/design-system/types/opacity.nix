{
  lib,
  mk-type,
  ...
}: {
  opacity = mk-type {
    name = "opacity";
    value-check = value:
      (lib.isInt value || lib.isFloat value)
      && value >= 0
      && value <= 1;
    rendered-values = value: {
      css = toString value;
      scss = toString value;
      qml = toString value;
      lua = toString value;
      rasi = toString value;
    };
  };
}
