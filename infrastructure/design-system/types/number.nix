{
  lib,
  mk-type,
  ...
}: {
  number = mk-type {
    value-check = value: lib.isInt value || lib.isFloat value;
    rendered-values = value: {
      scss = builtins.toJSON value;
      qml = builtins.toJSON value;
      lua = builtins.toJSON value;
    };
  };
}
