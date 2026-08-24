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
        milliseconds = builtins.floor (
          (
            if unit == "s"
            then value * 1000
            else value
          )
          + 0.5
        );
      in {
        scss = "${builtins.toJSON value}${unit}";
        qml = toString milliseconds;
        lua = toString milliseconds;
      };
    });
}
