{settings, ...}: let
  inherit (settings) palette;
in {
  "workbench.colorCustomizations" = {
    "peekView.border" = palette.blue;

    "peekViewEditor.background" = palette.black;
    "peekViewEditor.matchHighlightBackground" = "${palette.blue}33";

    "peekViewResult.background" = palette.black;
    "peekViewResult.fileForeground" = palette.white;
    "peekViewResult.lineForeground" = palette.light-gray;
    "peekViewResult.matchHighlightBackground" = "${palette.blue}33";
    "peekViewResult.selectionBackground" = "${palette.blue}26";
    "peekViewResult.selectionForeground" = palette.white;

    "peekViewTitle.background" = palette.black;

    "peekViewTitleDescription.foreground" = palette.light-gray;

    "peekViewTitleLabel.foreground" = palette.white;
  };
}
