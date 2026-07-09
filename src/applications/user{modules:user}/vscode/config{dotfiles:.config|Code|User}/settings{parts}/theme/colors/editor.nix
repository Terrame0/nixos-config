{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "contrastBorder" = invisible;

    "descriptionForeground" = palette.light-gray;

    "disabledForeground" = palette.light-gray;

    "editor.background" = palette.black;
    "editor.errorDecoration" = "underline";
    "editor.findMatchBackground" = palette.green;
    "editor.findMatchBorder" = invisible;
    "editor.findMatchForeground" = palette.black;
    "editor.findMatchHighlightBackground" = palette.white;
    "editor.findMatchHighlightBorder" = invisible;
    "editor.findMatchHighlightForeground" = palette.black;
    "editor.findRangeHighlightBackground" = palette.black;
    "editor.foreground" = palette.white;
    "editor.guides.bracketPairs" = palette.dim-gray;
    "editor.guides.bracketPairsActive" = palette.dim-gray;
    "editor.hoverHighlightBackground" = palette.black;
    "editor.inactiveSelectionBackground" = "${palette.blue}1a";
    "editor.infoDecoration" = "underline";
    "editor.lineHighlightBackground" = palette.dark-gray;
    "editor.rangeHighlightBackground" = palette.black;
    "editor.selectionBackground" = palette.dim-gray;
    "editor.selectionForeground" = palette.white;
    "editor.selectionHighlightBackground" = palette.dim-gray;
    "editor.selectionHighlightBorder" = invisible;
    "editor.warningDecoration" = "underline";
    "editor.wordHighlightBackground" = "${palette.blue}2E";
    "editor.wordHighlightStrongBackground" = "${palette.blue}2E";

    "editorBracketHighlight.foreground1" = palette.light-gray;
    "editorBracketHighlight.foreground2" = palette.light-gray;
    "editorBracketHighlight.foreground3" = palette.light-gray;
    "editorBracketHighlight.foreground4" = palette.light-gray;
    "editorBracketHighlight.foreground5" = palette.light-gray;
    "editorBracketHighlight.foreground6" = palette.light-gray;

    "editorBracketMatch.background" = invisible;
    "editorBracketMatch.border" = invisible;

    "editorBracketPairGuide.activeBackground1" = invisible;
    "editorBracketPairGuide.activeBackground2" = invisible;
    "editorBracketPairGuide.activeBackground3" = invisible;
    "editorBracketPairGuide.activeBackground4" = invisible;
    "editorBracketPairGuide.activeBackground5" = invisible;
    "editorBracketPairGuide.activeBackground6" = invisible;
    "editorBracketPairGuide.background1" = invisible;
    "editorBracketPairGuide.background2" = invisible;
    "editorBracketPairGuide.background3" = invisible;
    "editorBracketPairGuide.background4" = invisible;
    "editorBracketPairGuide.background5" = invisible;
    "editorBracketPairGuide.background6" = invisible;

    "editorCodeLens.foreground" = palette.light-gray;

    "editorCommentsWidget.rangeActiveBackground" = palette.black;
    "editorCommentsWidget.rangeBackground" = palette.black;

    "editorCursor.background" = palette.black;
    "editorCursor.foreground" = palette.white;

    "editorIndentGuide.activeBackground1" = palette.gray;
    "editorIndentGuide.background1" = palette.dark-gray;

    "editorLineNumber.activeForeground" = palette.white;
    "editorLineNumber.foreground" = palette.gray;

    "editorLink.activeForeground" = palette.blue;

    "editorRuler.foreground" = palette.dim-gray;

    "editorStickyScroll.border" = palette.dark-gray;
    "editorStickyScroll.shadow" = invisible;

    "editorStickyScrollHover.background" = palette.black;

    "editorWhitespace.foreground" = "${palette.light-gray}40";

    "focusBorder" = invisible;

    "foreground" = palette.white;

    "icon.foreground" = palette.light-gray;

    "keybindingLabel.foreground" = palette.white;

    "minimapSlider.activeBackground" = "${palette.gray}55";
    "minimapSlider.background" = "${palette.gray}26";
    "minimapSlider.hoverBackground" = "${palette.gray}40";
  };
}
