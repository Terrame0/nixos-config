{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "editorGroup.border" = invisible;

    "editorGroupHeader.tabsBackground" = palette.black;
    "editorGroupHeader.tabsBorder" = palette.dark-gray;

    "problems.decorations.enabled" = false;

    "scm.diffDecorations" = "none";

    "tab.activeBackground" = palette.dark-gray;
    "tab.activeBorder" = invisible;
    "tab.activeBorderTop" = invisible;
    "tab.activeForeground" = palette.white;
    "tab.activeModifiedBorder" = invisible;
    "tab.activeModifiedForeground" = palette.black;
    "tab.border" = invisible;
    "tab.hoverBackground" = palette.dark-gray;
    "tab.hoverForeground" = palette.white;
    "tab.inactiveBackground" = palette.black;
    "tab.inactiveBorder" = invisible;
    "tab.inactiveForeground" = palette.light-gray;
    "tab.inactiveModifiedForeground" = palette.light-gray;
    "tab.lastPinnedBorder" = palette.dark-gray;
    "tab.selectedBackground" = "${palette.dim-gray}a5";
    "tab.selectedBorderTop" = invisible;
    "tab.selectedForeground" = "${palette.white}b3";
    "tab.unfocusedActiveBackground" = palette.dark-gray;
    "tab.unfocusedActiveBorder" = invisible;
    "tab.unfocusedActiveBorderTop" = invisible;
    "tab.unfocusedActiveForeground" = palette.light-gray;
    "tab.unfocusedHoverBackground" = palette.dark-gray;
    "tab.unfocusedInactiveBackground" = palette.black;
    "tab.unfocusedInactiveBorder" = invisible;
    "tab.unfocusedInactiveForeground" = palette.light-gray;
  };
}
