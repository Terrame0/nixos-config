{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
in {
  "workbench.colorCustomizations" = {
    "notebook.cellBorderColor" = palette.neutral-800;
    "notebook.selectedCellBackground" = "${palette.neutral-600}50";
  };
}
