{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "activityBar.activeBorder" = invisible;
    "activityBar.activeFocusBorder" = invisible;
    "activityBar.background" = palette.neutral-1000;
    "activityBar.border" = invisible;
    "activityBar.foreground" = palette.neutral-0;
    "activityBar.inactiveForeground" = palette.neutral-200;

    "activityBarBadge.background" = palette.purple;
    "activityBarBadge.foreground" = palette.neutral-1000;

    "activityBarTop.activeBorder" = invisible;

    "list.activeSelectionBackground" = palette.neutral-600;
    "list.activeSelectionForeground" = palette.neutral-0;
    "list.activeSelectionIconForeground" = palette.green;
    "list.dropBackground" = "${palette.blue}15";
    "list.errorForeground" = palette.red;
    "list.focusAndSelectionOutline" = invisible;
    "list.focusBackground" = "${palette.blue}1a";
    "list.focusForeground" = palette.neutral-0;
    "list.focusHighlightForeground" = palette.green;
    "list.focusOutline" = invisible;
    "list.foreground" = palette.neutral-0;
    "list.highlightForeground" = palette.neutral-0;
    "list.hoverBackground" = palette.neutral-800;
    "list.hoverForeground" = palette.neutral-0;
    "list.inactiveSelectionBackground" = palette.neutral-800;
    "list.inactiveSelectionForeground" = palette.neutral-0;
    "list.invalidItemForeground" = palette.neutral-200;
    "list.warningForeground" = palette.yellow;

    "listFilterWidget.shadow" = invisible;

    "sideBar.background" = palette.neutral-1000;
    "sideBar.border" = palette.neutral-800;
    "sideBar.foreground" = palette.neutral-0;

    "sideBarSectionHeader.background" = palette.neutral-1000;
    "sideBarSectionHeader.border" = palette.neutral-800;
    "sideBarSectionHeader.foreground" = palette.neutral-0;

    "sideBarStickyScroll.shadow" = invisible;

    "sideBarTitle.foreground" = palette.neutral-0;

    "tree.indentGuidesStroke" = palette.neutral-0;
  };
}
