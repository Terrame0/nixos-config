{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "terminal.background" = palette.neutral-1000;
    "terminal.border" = palette.neutral-800;
    "terminal.foreground" = palette.neutral-0;
    "terminal.inactiveSelectionBackground" = palette.neutral-1000;
    "terminal.selectionBackground" = palette.neutral-600;

    "terminal.ansiBlack" = palette.neutral-200;
    "terminal.ansiBlue" = palette.blue;
    "terminal.ansiCyan" = palette.aqua;
    "terminal.ansiGreen" = palette.green;
    "terminal.ansiMagenta" = palette.purple;
    "terminal.ansiRed" = palette.red;
    "terminal.ansiWhite" = palette.neutral-0;
    "terminal.ansiYellow" = palette.yellow;
    "terminal.ansiBrightBlack" = palette.neutral-200;
    "terminal.ansiBrightBlue" = palette.blue;
    "terminal.ansiBrightCyan" = palette.aqua;
    "terminal.ansiBrightGreen" = palette.green;
    "terminal.ansiBrightMagenta" = palette.purple;
    "terminal.ansiBrightRed" = palette.red;
    "terminal.ansiBrightWhite" = palette.neutral-0;
    "terminal.ansiBrightYellow" = palette.yellow;

    "terminal.tab.activeBackground" = palette.neutral-800;
    "terminal.tab.activeBorder" = palette.neutral-800;
    "terminal.tab.activeBorderTop" = palette.neutral-800;
    "terminal.tab.activeForeground" = palette.neutral-0;
    "terminal.tab.activeIconForeground" = invisible;
    "terminal.tab.inactiveBackground" = palette.neutral-1000;
    "terminal.tab.inactiveForeground" = palette.neutral-200;
    "terminal.tab.inactiveIconForeground" = invisible;

    "terminalCursor.background" = palette.neutral-1000;
    "terminalCursor.foreground" = palette.neutral-0;
  };
}
