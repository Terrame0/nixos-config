{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "activityBar.activeBorder" = invisible;
    "activityBar.activeFocusBorder" = invisible;
    "activityBar.background" = palette.black;
    "activityBar.border" = invisible;
    "activityBar.foreground" = palette.white;
    "activityBar.inactiveForeground" = palette.light-gray;

    "activityBarBadge.background" = palette.purple;
    "activityBarBadge.foreground" = palette.black;

    "activityBarTop.activeBorder" = invisible;

    "list.activeSelectionBackground" = palette.dim-gray;
    "list.activeSelectionForeground" = palette.white;
    "list.activeSelectionIconForeground" = palette.green;
    "list.dropBackground" = "${palette.blue}15";
    "list.errorForeground" = palette.red;
    "list.focusAndSelectionOutline" = invisible;
    "list.focusBackground" = "${palette.blue}1a";
    "list.focusForeground" = palette.white;
    "list.focusHighlightForeground" = palette.green;
    "list.focusOutline" = invisible;
    "list.foreground" = palette.white;
    "list.highlightForeground" = palette.white;
    "list.hoverBackground" = palette.dark-gray;
    "list.hoverForeground" = palette.white;
    "list.inactiveSelectionBackground" = palette.dark-gray;
    "list.inactiveSelectionForeground" = palette.white;
    "list.invalidItemForeground" = palette.light-gray;
    "list.warningForeground" = palette.yellow;

    "listFilterWidget.shadow" = invisible;

    "sideBar.background" = palette.black;
    "sideBar.border" = palette.dark-gray;
    "sideBar.foreground" = palette.white;

    "sideBarSectionHeader.background" = palette.black;
    "sideBarSectionHeader.border" = palette.dark-gray;
    "sideBarSectionHeader.foreground" = palette.white;

    "sideBarStickyScroll.shadow" = invisible;

    "sideBarTitle.foreground" = palette.white;

    "tree.indentGuidesStroke" = palette.white;
  };
}
