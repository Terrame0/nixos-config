{
  lib,
  mk-type,
  ...
}: {
  dimension = lib.genAttrs ["px" "pt"] (unit:
    mk-type {
      value-check = value: lib.isInt value || lib.isFloat value;
      rendered-values = value: {
        scss = "${toString value}${unit}";
        qml = "${toString value}";
        lua = "${toString value}";
      };
    });
}
