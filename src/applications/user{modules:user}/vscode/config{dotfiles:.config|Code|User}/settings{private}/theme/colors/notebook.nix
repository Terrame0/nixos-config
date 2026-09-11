{settings, ...}: let
  inherit (settings) palette;
in {
  "workbench.colorCustomizations" = {
    "notebook.cellBorderColor" = palette.dark-gray;
    "notebook.selectedCellBackground" = "${palette.dim-gray}50";
  };
}
