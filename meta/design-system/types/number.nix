{
  lib,
  mk-type,
  ...
}: {
  number = mk-type {
    name = "number";
    value-check = value: lib.isInt value || lib.isFloat value;
    native-repr = lib.id;
    consumer-repr = value: {
      css = toString value;
      scss = toString value;
      qml = toString value;
      lua = toString value;
      rasi = toString value;
    };
  };
}
