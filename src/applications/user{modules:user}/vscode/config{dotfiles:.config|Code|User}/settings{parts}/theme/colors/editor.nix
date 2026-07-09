{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "editor.background" = palette.black;
    "editor.foreground" = palette.white;

    "editor.selectionBackground" = palette.dim-gray;
    "editor.selectionForeground" = palette.white;
    "editor.selectionHighlightBackground" = palette.dim-gray;
    "editor.selectionHighlightBorder" = invisible;

    "editor.lineHighlightBackground" = palette.dark-gray;

    "editorCursor.foreground" = palette.white;
    "editorLineNumber.foreground" = palette.gray;
    "editorLineNumber.activeForeground" = palette.white;

    "focusBorder" = invisible;
    "contrastBorder" = invisible;

    "editor.findMatchForeground" = palette.black;
    "editor.findMatchBackground" = palette.green;
    "editor.findMatchBorder" = invisible;

    "editor.findMatchHighlightForeground" = palette.black;
    "editor.findMatchHighlightBackground" = palette.white;
    "editor.findMatchHighlightBorder" = invisible;

    "editor.wordHighlightBackground" = "${palette.blue}2E";
    "editor.wordHighlightStrongBackground" = "${palette.blue}2E";

    "editor.guides.bracketPairs" = palette.dim-gray;
    "editor.guides.bracketPairsActive" = palette.dim-gray;

    "editor.errorDecoration" = "underline";
    "editor.warningDecoration" = "underline";
    "editor.infoDecoration" = "underline";

    "editorCursor.background" = palette.black;

    "editorBracketMatch.background" = invisible;
    "editorBracketMatch.border" = invisible;

    "editorBracketHighlight.foreground1" = palette.light-gray;
    "editorBracketHighlight.foreground2" = palette.light-gray;
    "editorBracketHighlight.foreground3" = palette.light-gray;
    "editorBracketHighlight.foreground4" = palette.light-gray;
    "editorBracketHighlight.foreground5" = palette.light-gray;
    "editorBracketHighlight.foreground6" = palette.light-gray;

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

    "descriptionForeground" = palette.light-gray;
    "disabledForeground" = palette.light-gray;
    "editor.findRangeHighlightBackground" = palette.black;
    "editor.hoverHighlightBackground" = palette.black;
    "editor.inactiveSelectionBackground" = "${palette.blue}1a";
    "editor.rangeHighlightBackground" = palette.black;
    "editorCodeLens.foreground" = palette.light-gray;
    "editorCommentsWidget.rangeActiveBackground" = palette.black;
    "editorCommentsWidget.rangeBackground" = palette.black;
    "editorIndentGuide.activeBackground1" = palette.gray;
    "editorIndentGuide.background1" = palette.dark-gray;
    "editorLink.activeForeground" = palette.blue;
    "editorRuler.foreground" = palette.dim-gray;
    "editorStickyScroll.border" = palette.dark-gray;
    "editorStickyScroll.shadow" = invisible;
    "editorStickyScrollHover.background" = palette.black;
    "editorWhitespace.foreground" = "${palette.light-gray}40";
    "foreground" = palette.white;
    "icon.foreground" = palette.light-gray;
    "keybindingLabel.foreground" = palette.white;
    "minimapSlider.activeBackground" = "${palette.gray}55";
    "minimapSlider.background" = "${palette.gray}26";
    "minimapSlider.hoverBackground" = "${palette.gray}40";
  };
}
