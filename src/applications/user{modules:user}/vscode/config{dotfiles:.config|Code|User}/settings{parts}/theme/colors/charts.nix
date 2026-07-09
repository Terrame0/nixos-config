{settings, ...}: let
  inherit (settings) palette;
in {
  "workbench.colorCustomizations" = {
    "charts.blue" = palette.blue;
    "charts.foreground" = palette.white;
    "charts.green" = palette.green;
    "charts.lines" = "${palette.white}66";
    "charts.orange" = palette.orange;
    "charts.purple" = palette.purple;
    "charts.red" = palette.red;
    "charts.yellow" = palette.yellow;
  };
}
