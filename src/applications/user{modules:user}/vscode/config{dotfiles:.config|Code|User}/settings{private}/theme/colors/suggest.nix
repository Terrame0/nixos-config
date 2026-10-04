{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
in {
  "workbench.colorCustomizations" = {
    "editorSuggestWidget.background" = palette.neutral-1000;
    "editorSuggestWidget.border" = palette.neutral-800;
    "editorSuggestWidget.foreground" = palette.neutral-0;
    "editorSuggestWidget.highlightForeground" = palette.neutral-0;
    "editorSuggestWidget.selectedBackground" = palette.neutral-800;
    "editorSuggestWidget.selectedForeground" = palette.green;

    "suggestWidget.background" = palette.neutral-1000;
    "suggestWidget.border" = palette.neutral-800;
    "suggestWidget.detailForeground" = palette.neutral-0;
    "suggestWidget.documentationFontSize" = 12;
    "suggestWidget.foreground" = palette.neutral-0;
    "suggestWidget.highlightForeground" = palette.green;
    "suggestWidget.selectedBackground" = palette.neutral-600;
    "suggestWidget.selectedForeground" = palette.neutral-0;

    "suggestWidgetScrollbarSlider.activeBackground" = palette.neutral-0;
    "suggestWidgetScrollbarSlider.background" = palette.neutral-400;
    "suggestWidgetScrollbarSlider.hoverBackground" = palette.neutral-200;
  };
}
