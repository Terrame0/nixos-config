{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "panel.background" = palette.black;
    "panel.border" = palette.dark-gray;

    "panelTitle.activeBorder" = invisible;
    "panelTitle.activeForeground" = palette.white;
    "panelTitle.inactiveForeground" = palette.light-gray;

    "panelInput.border" = palette.dark-gray;
    "panelStickyScroll.shadow" = invisible;

    "input.background" = palette.dark-gray;
    "input.border" = palette.dark-gray;
    "input.foreground" = palette.white;
    "input.placeholderForeground" = palette.light-gray;

    "inputOption.activeBackground" = "${palette.blue}26";
    "inputOption.activeBorder" = palette.dark-gray;
    "inputOption.activeForeground" = palette.white;

    "dropdown.background" = palette.dark-gray;
    "dropdown.border" = palette.dark-gray;
    "dropdown.foreground" = palette.white;
    "dropdown.listBackground" = palette.dark-gray;

    "radio.activeBackground" = "${palette.orange}26";
    "radio.activeBorder" = palette.orange;
    "radio.activeForeground" = palette.white;
  };
}
