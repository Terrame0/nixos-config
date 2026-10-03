{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.colors.base;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "textBlockQuote.background" = palette.black;
    "textBlockQuote.border" = palette.dark-gray;

    "textCodeBlock.background" = palette.black;

    "textLink.activeForeground" = palette.blue;
    "textLink.border" = invisible;
    "textLink.foreground" = palette.blue;

    "textPreformat.background" = palette.black;
    "textPreformat.foreground" = palette.light-gray;

    "textSeparator.foreground" = palette.light-gray;
  };
}
