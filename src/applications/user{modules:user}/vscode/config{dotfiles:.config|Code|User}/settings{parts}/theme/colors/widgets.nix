{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "actionBar.toggledBackground" = palette.dim-gray;

    "activityErrorBadge.background" = palette.red;
    "activityErrorBadge.foreground" = palette.black;

    "activityWarningBadge.background" = palette.yellow;
    "activityWarningBadge.foreground" = palette.white;

    "badge.background" = palette.dark-gray;
    "badge.foreground" = palette.white;

    "button.background" = palette.dark-gray;
    "button.border" = invisible;
    "button.foreground" = palette.white;
    "button.hoverBackground" = palette.dim-gray;
    "button.secondaryBackground" = invisible;
    "button.secondaryForeground" = palette.white;
    "button.secondaryHoverBackground" = palette.dark-gray;

    "checkbox.background" = palette.dark-gray;
    "checkbox.border" = palette.dark-gray;
    "checkbox.foreground" = palette.light-gray;

    "debugConsole.errorForeground" = palette.red;
    "debugConsole.infoForeground" = palette.blue;
    "debugConsole.warningForeground" = palette.yellow;

    "debugConsoleLink.foreground" = palette.blue;

    "debugToolBar.background" = palette.dark-gray;
    "debugToolBar.border" = invisible;

    "editorHoverWidget.background" = palette.dark-gray;
    "editorHoverWidget.border" = invisible;
    "editorHoverWidget.foreground" = palette.white;

    "editorSuggestWidget.background" = palette.black;
    "editorSuggestWidget.border" = palette.dark-gray;
    "editorSuggestWidget.foreground" = palette.white;
    "editorSuggestWidget.highlightForeground" = palette.white;
    "editorSuggestWidget.selectedBackground" = palette.dark-gray;
    "editorSuggestWidget.selectedForeground" = palette.green;

    "editorWidget.background" = palette.dark-gray;
    "editorWidget.border" = palette.dim-gray;
    "editorWidget.foreground" = palette.white;

    "extensionButton.background" = palette.dark-gray;
    "extensionButton.foreground" = palette.white;
    "extensionButton.hoverBackground" = palette.dim-gray;
    "extensionButton.prominentBackground" = palette.dark-gray;
    "extensionButton.prominentForeground" = palette.white;
    "extensionButton.prominentHoverBackground" = palette.blue;
    "extensionButton.separator" = palette.gray;

    "pickerGroup.border" = palette.dark-gray;
    "pickerGroup.foreground" = palette.white;

    "ports.iconRunningProcessForeground" = palette.green;

    "progressBar.background" = palette.blue;

    "quickInput.background" = palette.dark-gray;
    "quickInput.foreground" = palette.white;

    "quickInputList.focusBackground" = palette.dim-gray;
    "quickInputList.focusForeground" = palette.white;
    "quickInputList.focusHighlightForeground" = palette.green;
    "quickInputList.focusIconForeground" = palette.black;

    "quickInputTitle.background" = palette.dark-gray;

    "scrollbar.shadow" = invisible;

    "scrollbarSlider.activeBackground" = palette.white;
    "scrollbarSlider.background" = "${palette.gray}99";
    "scrollbarSlider.hoverBackground" = "${palette.light-gray}cc";

    "searchEditor.textInputBorder" = palette.dark-gray;

    "settings.dropdownBackground" = palette.dark-gray;
    "settings.dropdownBorder" = palette.dark-gray;
    "settings.headerForeground" = palette.white;
    "settings.modifiedItemIndicator" = "${palette.orange}66";
    "settings.numberInputBorder" = palette.dark-gray;
    "settings.textInputBorder" = palette.dark-gray;

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

    "symbolIcon.textForeground" = palette.white;

    "toolbar.hoverBackground" = "${palette.gray}10";

    "welcomePage.tileBackground" = palette.black;

    "widget.border" = palette.dim-gray;
    "widget.shadow" = invisible;
  };
}
