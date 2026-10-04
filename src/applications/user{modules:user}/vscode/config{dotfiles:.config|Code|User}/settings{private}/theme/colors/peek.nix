{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
in {
  "workbench.colorCustomizations" = {
    "peekView.border" = palette.blue;

    "peekViewEditor.background" = palette.neutral-1000;
    "peekViewEditor.matchHighlightBackground" = "${palette.blue}33";

    "peekViewResult.background" = palette.neutral-1000;
    "peekViewResult.fileForeground" = palette.neutral-0;
    "peekViewResult.lineForeground" = palette.neutral-200;
    "peekViewResult.matchHighlightBackground" = "${palette.blue}33";
    "peekViewResult.selectionBackground" = "${palette.blue}26";
    "peekViewResult.selectionForeground" = palette.neutral-0;

    "peekViewTitle.background" = palette.neutral-1000;

    "peekViewTitleDescription.foreground" = palette.neutral-200;

    "peekViewTitleLabel.foreground" = palette.neutral-0;
  };
}
