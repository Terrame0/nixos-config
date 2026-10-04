{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "textBlockQuote.background" = palette.neutral-1000;
    "textBlockQuote.border" = palette.neutral-800;

    "textCodeBlock.background" = palette.neutral-1000;

    "textLink.activeForeground" = palette.blue;
    "textLink.border" = invisible;
    "textLink.foreground" = palette.blue;

    "textPreformat.background" = palette.neutral-1000;
    "textPreformat.foreground" = palette.neutral-200;

    "textSeparator.foreground" = palette.neutral-200;
  };
}
