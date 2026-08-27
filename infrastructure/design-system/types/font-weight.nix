{
  lib,
  mk-type,
  ...
}: {
  font-weight = mk-type {
    name = "font-weight";
    value-check = value:
      lib.isInt value
      && value >= 1
      && value <= 1000;
    rendered-values = value: {
      scss = toString value;
      qml = toString value;
      lua = toString value;
      rasi = toString value;
    };
  };
}
