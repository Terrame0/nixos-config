{settings, ...}: let
  inherit (settings) palette;
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
