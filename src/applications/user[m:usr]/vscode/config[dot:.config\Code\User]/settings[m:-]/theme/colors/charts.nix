{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
in {
  "workbench.colorCustomizations" = {
    "charts.blue" = palette.blue;
    "charts.foreground" = palette.neutral-0;
    "charts.green" = palette.green;
    "charts.lines" = "${palette.neutral-0}66";
    "charts.orange" = palette.orange;
    "charts.purple" = palette.purple;
    "charts.red" = palette.red;
    "charts.yellow" = palette.yellow;
  };
}
