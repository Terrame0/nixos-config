{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "panel.background" = palette.black;
    "panel.border" = palette.dark-gray;
    "panelTitle.activeForeground" = palette.white;
    "panelTitle.inactiveForeground" = palette.light-gray;

    "input.background" = palette.dark-gray;
    "input.foreground" = palette.white;
    "input.border" = palette.dark-gray;

    "dropdown.background" = palette.dark-gray;
    "dropdown.foreground" = palette.white;
    "dropdown.border" = palette.dark-gray;

    "terminal.background" = palette.black;
    "terminal.foreground" = palette.white;
    "terminal.border" = palette.dark-gray;
    "terminal.selectionBackground" = palette.dim-gray;

    "terminal.tab.activeBackground" = palette.dark-gray;
    "terminal.tab.activeForeground" = palette.white;
    "terminal.tab.inactiveBackground" = palette.black;
    "terminal.tab.inactiveForeground" = palette.light-gray;
    "terminal.tab.activeBorder" = palette.dark-gray;
    "terminal.tab.activeBorderTop" = palette.dark-gray;
    "terminal.tab.activeIconForeground" = invisible;
    "terminal.tab.inactiveIconForeground" = invisible;

    "terminal.ansiBlack" = palette.light-gray;
    "terminal.ansiRed" = palette.red;
    "terminal.ansiGreen" = palette.green;
    "terminal.ansiYellow" = palette.yellow;
    "terminal.ansiBlue" = palette.blue;
    "terminal.ansiMagenta" = palette.purple;
    "terminal.ansiCyan" = palette.aqua;
    "terminal.ansiWhite" = palette.white;

    "terminal.ansiBrightBlack" = palette.light-gray;
    "terminal.ansiBrightRed" = palette.red;
    "terminal.ansiBrightGreen" = palette.green;
    "terminal.ansiBrightYellow" = palette.yellow;
    "terminal.ansiBrightBlue" = palette.blue;
    "terminal.ansiBrightMagenta" = palette.purple;
    "terminal.ansiBrightCyan" = palette.aqua;
    "terminal.ansiBrightWhite" = palette.white;

    "dropdown.listBackground" = palette.dark-gray;
    "input.placeholderForeground" = palette.light-gray;
    "inputOption.activeBackground" = "${palette.blue}26";
    "inputOption.activeBorder" = palette.dark-gray;
    "inputOption.activeForeground" = palette.white;
    "panelInput.border" = palette.dark-gray;
    "panelStickyScroll.shadow" = invisible;
    "panelTitle.activeBorder" = invisible;
    "terminal.inactiveSelectionBackground" = palette.black;
    "terminalCursor.background" = palette.black;
    "terminalCursor.foreground" = palette.white;
  };
}
