{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "scrollbar.shadow" = invisible;

    "scrollbarSlider.activeBackground" = palette.white;
    "scrollbarSlider.background" = "${palette.gray}99";
    "scrollbarSlider.hoverBackground" = "${palette.light-gray}cc";
  };
}
