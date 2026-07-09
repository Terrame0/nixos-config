{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "scrollbar.shadow" = invisible;
    "scrollbarSlider.background" = "${palette.gray}99";
    "scrollbarSlider.hoverBackground" = "${palette.light-gray}cc";
    "scrollbarSlider.activeBackground" = palette.white;

    "editorHoverWidget.background" = palette.dark-gray;
    "editorHoverWidget.foreground" = palette.white;
    "editorHoverWidget.border" = invisible;

    "suggestWidget.background" = palette.black;
    "suggestWidget.foreground" = palette.white;
    "suggestWidget.border" = palette.dark-gray;
    "suggestWidget.selectedBackground" = palette.dim-gray;
    "suggestWidget.selectedForeground" = palette.white;
    "suggestWidget.highlightForeground" = palette.green;
    "suggestWidget.detailForeground" = palette.white;
    "suggestWidget.documentationFontSize" = 12;

    "suggestWidgetScrollbarSlider.background" = palette.gray;
    "suggestWidgetScrollbarSlider.hoverBackground" = palette.light-gray;
    "suggestWidgetScrollbarSlider.activeBackground" = palette.white;

    "editorSuggestWidget.background" = palette.black;
    "editorSuggestWidget.foreground" = palette.white;
    "editorSuggestWidget.border" = palette.dark-gray;
    "editorSuggestWidget.highlightForeground" = palette.white;
    "editorSuggestWidget.selectedBackground" = palette.dark-gray;
    "editorSuggestWidget.selectedForeground" = palette.green;

    "button.background" = palette.dark-gray;
    "button.foreground" = palette.white;
    "button.hoverBackground" = palette.dim-gray;
    "button.border" = invisible;
    "button.secondaryBackground" = invisible;
    "button.secondaryForeground" = palette.white;

    "badge.background" = palette.dark-gray;
    "badge.foreground" = palette.white;

    "extensionButton.background" = palette.dark-gray;
    "extensionButton.foreground" = palette.white;
    "extensionButton.hoverBackground" = palette.dim-gray;
    "extensionButton.prominentBackground" = palette.dark-gray;
    "extensionButton.prominentForeground" = palette.white;
    "extensionButton.separator" = palette.gray;

    "debugToolBar.background" = palette.dark-gray;
    "debugToolBar.border" = invisible;

    "textLink.foreground" = palette.blue;
    "textLink.activeForeground" = palette.blue;
    "textLink.border" = invisible;

    "debugConsole.infoForeground" = palette.blue;
    "debugConsole.warningForeground" = palette.yellow;
    "debugConsole.errorForeground" = palette.red;
    "debugConsoleLink.foreground" = palette.blue;

    "symbolIcon.textForeground" = palette.white;
  };
}
