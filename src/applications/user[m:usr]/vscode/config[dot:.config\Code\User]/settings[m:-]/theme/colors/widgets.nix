{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "editorHoverWidget.background" = palette.neutral-800;
    "editorHoverWidget.border" = invisible;
    "editorHoverWidget.foreground" = palette.neutral-0;

    "editorWidget.background" = palette.neutral-800;
    "editorWidget.border" = palette.neutral-600;
    "editorWidget.foreground" = palette.neutral-0;

    "widget.border" = palette.neutral-600;
    "widget.shadow" = invisible;

    "quickInput.background" = palette.neutral-800;
    "quickInput.foreground" = palette.neutral-0;

    "quickInputList.focusBackground" = palette.neutral-600;
    "quickInputList.focusForeground" = palette.neutral-0;
    "quickInputList.focusHighlightForeground" = palette.green;
    "quickInputList.focusIconForeground" = palette.neutral-1000;

    "quickInputTitle.background" = palette.neutral-800;

    "pickerGroup.border" = palette.neutral-800;
    "pickerGroup.foreground" = palette.neutral-0;

    "debugConsole.errorForeground" = palette.red;
    "debugConsole.infoForeground" = palette.blue;
    "debugConsole.warningForeground" = palette.yellow;
    "debugConsoleLink.foreground" = palette.blue;

    "debugToolBar.background" = palette.neutral-800;
    "debugToolBar.border" = invisible;

    "settings.dropdownBackground" = palette.neutral-800;
    "settings.dropdownBorder" = palette.neutral-800;
    "settings.headerForeground" = palette.neutral-0;
    "settings.modifiedItemIndicator" = "${palette.orange}66";
    "settings.numberInputBorder" = palette.neutral-800;
    "settings.textInputBorder" = palette.neutral-800;

    "searchEditor.textInputBorder" = palette.neutral-800;

    "symbolIcon.textForeground" = palette.neutral-0;

    "ports.iconRunningProcessForeground" = palette.green;

    "toolbar.hoverBackground" = "${palette.neutral-400}10";
    "toolbar.activeBackground" = "${palette.neutral-400}20";

    "welcomePage.tileBackground" = palette.neutral-1000;
  };
}
