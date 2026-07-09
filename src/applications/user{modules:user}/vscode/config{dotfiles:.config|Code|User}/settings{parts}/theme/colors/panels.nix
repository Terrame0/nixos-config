{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "dropdown.background" = palette.dark-gray;
    "dropdown.border" = palette.dark-gray;
    "dropdown.foreground" = palette.white;
    "dropdown.listBackground" = palette.dark-gray;

    "input.background" = palette.dark-gray;
    "input.border" = palette.dark-gray;
    "input.foreground" = palette.white;
    "input.placeholderForeground" = palette.light-gray;

    "inputOption.activeBackground" = "${palette.blue}26";
    "inputOption.activeBorder" = palette.dark-gray;
    "inputOption.activeForeground" = palette.white;

    "panel.background" = palette.black;
    "panel.border" = palette.dark-gray;

    "panelInput.border" = palette.dark-gray;

    "panelStickyScroll.shadow" = invisible;

    "panelTitle.activeBorder" = invisible;
    "panelTitle.activeForeground" = palette.white;
    "panelTitle.inactiveForeground" = palette.light-gray;

    "radio.activeBackground" = "${palette.orange}26";
    "radio.activeBorder" = palette.orange;
    "radio.activeForeground" = palette.white;

    "terminal.ansiBlack" = palette.light-gray;
    "terminal.ansiBlue" = palette.blue;
    "terminal.ansiBrightBlack" = palette.light-gray;
    "terminal.ansiBrightBlue" = palette.blue;
    "terminal.ansiBrightCyan" = palette.aqua;
    "terminal.ansiBrightGreen" = palette.green;
    "terminal.ansiBrightMagenta" = palette.purple;
    "terminal.ansiBrightRed" = palette.red;
    "terminal.ansiBrightWhite" = palette.white;
    "terminal.ansiBrightYellow" = palette.yellow;
    "terminal.ansiCyan" = palette.aqua;
    "terminal.ansiGreen" = palette.green;
    "terminal.ansiMagenta" = palette.purple;
    "terminal.ansiRed" = palette.red;
    "terminal.ansiWhite" = palette.white;
    "terminal.ansiYellow" = palette.yellow;
    "terminal.background" = palette.black;
    "terminal.border" = palette.dark-gray;
    "terminal.foreground" = palette.white;
    "terminal.inactiveSelectionBackground" = palette.black;
    "terminal.selectionBackground" = palette.dim-gray;
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
