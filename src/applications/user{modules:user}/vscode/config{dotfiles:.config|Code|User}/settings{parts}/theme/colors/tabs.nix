{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "tab.activeBackground" = palette.dark-gray;
    "tab.activeForeground" = palette.white;

    "tab.inactiveBackground" = palette.black;
    "tab.inactiveForeground" = palette.light-gray;

    "tab.inactiveBorder" = invisible;
    "tab.unfocusedInactiveBorder" = invisible;
    "tab.activeBorderTop" = invisible;
    "tab.unfocusedActiveBorderTop" = invisible;
    "tab.selectedBorderTop" = invisible;
    "tab.border" = invisible;
    "tab.activeBorder" = invisible;
    "tab.unfocusedActiveBorder" = invisible;
    "tab.activeModifiedBorder" = invisible;

    "tab.activeModifiedForeground" = palette.black;
    "tab.inactiveModifiedForeground" = palette.light-gray;

    "problems.decorations.enabled" = false;
    "scm.diffDecorations" = "none";

    "editorGroup.border" = invisible;
    "editorGroupHeader.tabsBackground" = palette.black;
    "editorGroupHeader.tabsBorder" = palette.dark-gray;

    "tab.hoverBackground" = palette.dark-gray;
    "tab.hoverForeground" = palette.white;
    "tab.lastPinnedBorder" = palette.dark-gray;
    "tab.selectedBackground" = "${palette.dim-gray}a5";
    "tab.selectedForeground" = "${palette.white}b3";
    "tab.unfocusedActiveBackground" = palette.dark-gray;
    "tab.unfocusedActiveForeground" = palette.light-gray;
    "tab.unfocusedHoverBackground" = palette.dark-gray;
    "tab.unfocusedInactiveBackground" = palette.black;
    "tab.unfocusedInactiveForeground" = palette.light-gray;
  };
}
