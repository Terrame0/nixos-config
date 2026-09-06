{
  lib,
  mk-type,
  ...
}: {
  dimension = lib.genAttrs ["px" "pt"] (unit:
    mk-type {
      name = "dimension.${unit}";
      value-check = value: lib.isInt value || lib.isFloat value;
      rendered-values = value: {
        css = "${toString value}${unit}";
        scss = "${toString value}${unit}";
        qml = "${toString value}";
        lua = "${toString value}";
        rasi =
          if unit == "px"
          then "${toString value}px"
          else toString value;
      };
    });
}
