{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "scrollbar.shadow" = invisible;

    "scrollbarSlider.activeBackground" = palette.neutral-0;
    "scrollbarSlider.background" = "${palette.neutral-400}99";
    "scrollbarSlider.hoverBackground" = "${palette.neutral-200}cc";
  };
}
