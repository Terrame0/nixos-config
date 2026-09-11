{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "contrastBorder" = invisible;
    "focusBorder" = invisible;

    "foreground" = palette.white;
    "descriptionForeground" = palette.light-gray;
    "disabledForeground" = palette.light-gray;
    "icon.foreground" = palette.light-gray;
    "keybindingLabel.foreground" = palette.white;

    "editor.background" = palette.black;
    "editor.foreground" = palette.white;
    "editor.errorDecoration" = "underline";
    "editor.warningDecoration" = "underline";
    "editor.infoDecoration" = "underline";

    "editor.findMatchBackground" = palette.green;
    "editor.findMatchBorder" = invisible;
    "editor.findMatchForeground" = palette.black;
    "editor.findMatchHighlightBackground" = palette.white;
    "editor.findMatchHighlightBorder" = invisible;
    "editor.findMatchHighlightForeground" = palette.black;
    "editor.findRangeHighlightBackground" = palette.black;

    "editor.hoverHighlightBackground" = palette.black;
    "editor.inactiveSelectionBackground" = "${palette.blue}1a";
    "editor.lineHighlightBackground" = palette.dark-gray;
    "editor.rangeHighlightBackground" = palette.black;
    "editor.selectionBackground" = palette.dim-gray;
    "editor.selectionForeground" = palette.white;
    "editor.selectionHighlightBackground" = palette.dim-gray;
    "editor.selectionHighlightBorder" = invisible;
    "editor.wordHighlightBackground" = "${palette.blue}2E";
    "editor.wordHighlightStrongBackground" = "${palette.blue}2E";

    "editorCursor.background" = palette.black;
    "editorCursor.foreground" = palette.white;

    "editorLineNumber.activeForeground" = palette.white;
    "editorLineNumber.foreground" = palette.gray;

    "editorIndentGuide.activeBackground1" = palette.gray;
    "editorIndentGuide.background1" = palette.dark-gray;

    "editorWhitespace.foreground" = "${palette.light-gray}40";
    "editorRuler.foreground" = palette.dim-gray;

    "editorCodeLens.foreground" = palette.light-gray;
    "editorLink.activeForeground" = palette.blue;

    "editorCommentsWidget.rangeActiveBackground" = palette.black;
    "editorCommentsWidget.rangeBackground" = palette.black;

    "editorStickyScroll.border" = palette.dark-gray;
    "editorStickyScroll.shadow" = invisible;
    "editorStickyScrollHover.background" = palette.black;

    "minimapSlider.activeBackground" = "${palette.gray}55";
    "minimapSlider.background" = "${palette.gray}26";
    "minimapSlider.hoverBackground" = "${palette.gray}40";
  };
}
