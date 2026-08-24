{
  lib,
  mk-type,
  ...
}: {
  number = mk-type {
    value-check = value: lib.isInt value || lib.isFloat value;
    rendered-values = value: {
      scss = toString value;
      qml = toString value;
      lua = toString value;
    };
  };
}
