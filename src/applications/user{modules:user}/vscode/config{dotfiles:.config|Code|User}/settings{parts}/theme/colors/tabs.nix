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
  };
}
