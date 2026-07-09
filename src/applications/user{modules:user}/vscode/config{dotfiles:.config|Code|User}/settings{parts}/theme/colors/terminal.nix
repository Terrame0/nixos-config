{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "terminal.background" = palette.black;
    "terminal.border" = palette.dark-gray;
    "terminal.foreground" = palette.white;
    "terminal.inactiveSelectionBackground" = palette.black;
    "terminal.selectionBackground" = palette.dim-gray;

    "terminal.ansiBlack" = palette.light-gray;
    "terminal.ansiBlue" = palette.blue;
    "terminal.ansiCyan" = palette.aqua;
    "terminal.ansiGreen" = palette.green;
    "terminal.ansiMagenta" = palette.purple;
    "terminal.ansiRed" = palette.red;
    "terminal.ansiWhite" = palette.white;
    "terminal.ansiYellow" = palette.yellow;
    "terminal.ansiBrightBlack" = palette.light-gray;
    "terminal.ansiBrightBlue" = palette.blue;
    "terminal.ansiBrightCyan" = palette.aqua;
    "terminal.ansiBrightGreen" = palette.green;
    "terminal.ansiBrightMagenta" = palette.purple;
    "terminal.ansiBrightRed" = palette.red;
    "terminal.ansiBrightWhite" = palette.white;
    "terminal.ansiBrightYellow" = palette.yellow;

    "terminal.tab.activeBackground" = palette.dark-gray;
    "terminal.tab.activeBorder" = palette.dark-gray;
    "terminal.tab.activeBorderTop" = palette.dark-gray;
    "terminal.tab.activeForeground" = palette.white;
    "terminal.tab.activeIconForeground" = invisible;
    "terminal.tab.inactiveBackground" = palette.black;
    "terminal.tab.inactiveForeground" = palette.light-gray;
    "terminal.tab.inactiveIconForeground" = invisible;

    "terminalCursor.background" = palette.black;
    "terminalCursor.foreground" = palette.white;
  };
}
