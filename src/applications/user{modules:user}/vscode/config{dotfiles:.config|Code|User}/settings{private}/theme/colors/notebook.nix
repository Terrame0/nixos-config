{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.colors.base;
in {
  "workbench.colorCustomizations" = {
    "notebook.cellBorderColor" = palette.dark-gray;
    "notebook.selectedCellBackground" = "${palette.dim-gray}50";
  };
}
