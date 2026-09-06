{
  lib,
  mk-type,
  ...
}: {
  duration = lib.genAttrs ["ms" "s"] (unit:
    mk-type {
      name = "duration.${unit}";
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
        css = "${toString value}${unit}";
        scss = "${toString value}${unit}";
        qml = toString milliseconds;
        lua = toString milliseconds;
        rasi = toString milliseconds;
      };
    });
}
