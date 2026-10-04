{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "contrastBorder" = invisible;
    "focusBorder" = invisible;

    "foreground" = palette.neutral-0;
    "descriptionForeground" = palette.neutral-200;
    "disabledForeground" = palette.neutral-200;
    "icon.foreground" = palette.neutral-200;
    "keybindingLabel.foreground" = palette.neutral-0;

    "editor.background" = palette.neutral-1000;
    "editor.foreground" = palette.neutral-0;
    "editor.errorDecoration" = "underline";
    "editor.warningDecoration" = "underline";
    "editor.infoDecoration" = "underline";

    "editor.findMatchBackground" = palette.green;
    "editor.findMatchBorder" = invisible;
    "editor.findMatchForeground" = palette.neutral-1000;
    "editor.findMatchHighlightBackground" = palette.neutral-0;
    "editor.findMatchHighlightBorder" = invisible;
    "editor.findMatchHighlightForeground" = palette.neutral-1000;
    "editor.findRangeHighlightBackground" = palette.neutral-1000;

    "editor.hoverHighlightBackground" = palette.neutral-1000;
    "editor.inactiveSelectionBackground" = "${palette.blue}1a";
    "editor.lineHighlightBackground" = palette.neutral-800;
    "editor.rangeHighlightBackground" = palette.neutral-1000;
    "editor.selectionBackground" = palette.neutral-600;
    "editor.selectionForeground" = palette.neutral-0;
    "editor.selectionHighlightBackground" = palette.neutral-600;
    "editor.selectionHighlightBorder" = invisible;
    "editor.wordHighlightBackground" = "${palette.blue}2E";
    "editor.wordHighlightStrongBackground" = "${palette.blue}2E";

    "editorCursor.background" = palette.neutral-1000;
    "editorCursor.foreground" = palette.neutral-0;

    "editorLineNumber.activeForeground" = palette.neutral-0;
    "editorLineNumber.foreground" = palette.neutral-400;

    "editorIndentGuide.activeBackground1" = palette.neutral-400;
    "editorIndentGuide.background1" = palette.neutral-800;

    "editorWhitespace.foreground" = "${palette.neutral-200}40";
    "editorRuler.foreground" = palette.neutral-600;

    "editorCodeLens.foreground" = palette.neutral-200;
    "editorLink.activeForeground" = palette.blue;

    "editorCommentsWidget.rangeActiveBackground" = palette.neutral-1000;
    "editorCommentsWidget.rangeBackground" = palette.neutral-1000;

    "editorStickyScroll.border" = palette.neutral-800;
    "editorStickyScroll.shadow" = invisible;
    "editorStickyScrollHover.background" = palette.neutral-1000;

    "minimapSlider.activeBackground" = "${palette.neutral-400}55";
    "minimapSlider.background" = "${palette.neutral-400}26";
    "minimapSlider.hoverBackground" = "${palette.neutral-400}40";
  };
}
