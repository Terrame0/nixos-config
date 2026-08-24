{
  lib,
  mk-type,
  ...
}: {
  duration = lib.genAttrs ["ms" "s"] (unit:
    mk-type {
      value-check = value:
        (lib.isInt value || lib.isFloat value)
        && value >= 0;
      rendered-values = value: let
        milliseconds = lib.floor (
          (
            if unit == "s"
            then value * 1000
            else value
          )
          + 0.5
        );
      in {
        scss = "${lib.toJSON value}${unit}";
        qml = toString milliseconds;
        lua = toString milliseconds;
      };
    });
}
