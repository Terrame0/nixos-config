{settings, ...}: let
  inherit (settings) palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "editor.guides.bracketPairs" = palette.dim-gray;
    "editor.guides.bracketPairsActive" = palette.dim-gray;

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
  };
}
