{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "editorGroup.border" = invisible;

    "editorGroupHeader.tabsBackground" = palette.neutral-1000;
    "editorGroupHeader.tabsBorder" = palette.neutral-800;

    "problems.decorations.enabled" = false;

    "scm.diffDecorations" = "none";

    "tab.activeBackground" = palette.neutral-800;
    "tab.activeBorder" = invisible;
    "tab.activeBorderTop" = invisible;
    "tab.activeForeground" = palette.neutral-0;
    "tab.activeModifiedBorder" = invisible;
    "tab.activeModifiedForeground" = palette.neutral-1000;
    "tab.border" = invisible;
    "tab.hoverBackground" = palette.neutral-800;
    "tab.hoverForeground" = palette.neutral-0;
    "tab.inactiveBackground" = palette.neutral-1000;
    "tab.inactiveBorder" = invisible;
    "tab.inactiveForeground" = palette.neutral-200;
    "tab.inactiveModifiedForeground" = palette.neutral-200;
    "tab.lastPinnedBorder" = palette.neutral-800;
    "tab.selectedBackground" = "${palette.neutral-600}a5";
    "tab.selectedBorderTop" = invisible;
    "tab.selectedForeground" = "${palette.neutral-0}b3";
    "tab.unfocusedActiveBackground" = palette.neutral-800;
    "tab.unfocusedActiveBorder" = invisible;
    "tab.unfocusedActiveBorderTop" = invisible;
    "tab.unfocusedActiveForeground" = palette.neutral-200;
    "tab.unfocusedHoverBackground" = palette.neutral-800;
    "tab.unfocusedInactiveBackground" = palette.neutral-1000;
    "tab.unfocusedInactiveBorder" = invisible;
    "tab.unfocusedInactiveForeground" = palette.neutral-200;
  };
}
