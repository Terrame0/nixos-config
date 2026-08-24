{
  lib,
  mk-type,
  ...
}: {
  opacity = mk-type {
    value-check = value:
      (lib.isInt value || lib.isFloat value)
      && value >= 0
      && value <= 1;
    rendered-values = value: {
      scss = builtins.toJSON value;
      qml = builtins.toJSON value;
      lua = builtins.toJSON value;
    };
  };
}
