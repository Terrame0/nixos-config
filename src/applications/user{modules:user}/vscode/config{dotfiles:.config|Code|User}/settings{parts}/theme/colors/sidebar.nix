{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "activityBar.background" = palette.black;
    "activityBar.foreground" = palette.white;
    "activityBar.inactiveForeground" = palette.light-gray;
    "activityBar.border" = invisible;
    "activityBar.activeBorder" = invisible;
    "activityBar.activeFocusBorder" = invisible;

    "sideBar.background" = palette.black;
    "sideBar.foreground" = palette.white;
    "sideBar.border" = palette.dark-gray;

    "list.activeSelectionBackground" = palette.dim-gray;
    "list.activeSelectionForeground" = palette.white;
    "list.activeSelectionIconForeground" = palette.green;

    "list.inactiveSelectionBackground" = palette.dark-gray;
    "list.inactiveSelectionForeground" = palette.white;

    "list.hoverBackground" = palette.dark-gray;

    "list.foreground" = palette.white;
    "list.focusForeground" = palette.white;
    "list.focusOutline" = invisible;
    "list.highlightForeground" = palette.white;
    "list.focusHighlightForeground" = palette.green;

    "tree.indentGuidesStroke" = palette.white;
  };
}
