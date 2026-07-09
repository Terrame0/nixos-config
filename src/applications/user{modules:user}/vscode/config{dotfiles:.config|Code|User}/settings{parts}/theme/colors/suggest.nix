{settings, ...}: let
  inherit (settings) palette;
in {
  "workbench.colorCustomizations" = {
    "editorSuggestWidget.background" = palette.black;
    "editorSuggestWidget.border" = palette.dark-gray;
    "editorSuggestWidget.foreground" = palette.white;
    "editorSuggestWidget.highlightForeground" = palette.white;
    "editorSuggestWidget.selectedBackground" = palette.dark-gray;
    "editorSuggestWidget.selectedForeground" = palette.green;

    "suggestWidget.background" = palette.black;
    "suggestWidget.border" = palette.dark-gray;
    "suggestWidget.detailForeground" = palette.white;
    "suggestWidget.documentationFontSize" = 12;
    "suggestWidget.foreground" = palette.white;
    "suggestWidget.highlightForeground" = palette.green;
    "suggestWidget.selectedBackground" = palette.dim-gray;
    "suggestWidget.selectedForeground" = palette.white;

    "suggestWidgetScrollbarSlider.activeBackground" = palette.white;
    "suggestWidgetScrollbarSlider.background" = palette.gray;
    "suggestWidgetScrollbarSlider.hoverBackground" = palette.light-gray;
  };
}
