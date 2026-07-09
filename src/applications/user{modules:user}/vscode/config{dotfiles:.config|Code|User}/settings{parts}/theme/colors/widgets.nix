{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "editorHoverWidget.background" = palette.dark-gray;
    "editorHoverWidget.border" = invisible;
    "editorHoverWidget.foreground" = palette.white;

    "editorWidget.background" = palette.dark-gray;
    "editorWidget.border" = palette.dim-gray;
    "editorWidget.foreground" = palette.white;

    "widget.border" = palette.dim-gray;
    "widget.shadow" = invisible;

    "quickInput.background" = palette.dark-gray;
    "quickInput.foreground" = palette.white;

    "quickInputList.focusBackground" = palette.dim-gray;
    "quickInputList.focusForeground" = palette.white;
    "quickInputList.focusHighlightForeground" = palette.green;
    "quickInputList.focusIconForeground" = palette.black;

    "quickInputTitle.background" = palette.dark-gray;

    "pickerGroup.border" = palette.dark-gray;
    "pickerGroup.foreground" = palette.white;

    "debugConsole.errorForeground" = palette.red;
    "debugConsole.infoForeground" = palette.blue;
    "debugConsole.warningForeground" = palette.yellow;
    "debugConsoleLink.foreground" = palette.blue;

    "debugToolBar.background" = palette.dark-gray;
    "debugToolBar.border" = invisible;

    "settings.dropdownBackground" = palette.dark-gray;
    "settings.dropdownBorder" = palette.dark-gray;
    "settings.headerForeground" = palette.white;
    "settings.modifiedItemIndicator" = "${palette.orange}66";
    "settings.numberInputBorder" = palette.dark-gray;
    "settings.textInputBorder" = palette.dark-gray;

    "searchEditor.textInputBorder" = palette.dark-gray;

    "symbolIcon.textForeground" = palette.white;

    "ports.iconRunningProcessForeground" = palette.green;

    "toolbar.hoverBackground" = "${palette.gray}10";
    "toolbar.activeBackground" = "${palette.gray}20";

    "welcomePage.tileBackground" = palette.black;
  };
}
