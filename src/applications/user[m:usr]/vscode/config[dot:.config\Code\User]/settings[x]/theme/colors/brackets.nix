{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
  invisible = "#ffffff00";
in {
  "workbench.colorCustomizations" = {
    "editor.guides.bracketPairs" = palette.neutral-600;
    "editor.guides.bracketPairsActive" = palette.neutral-600;

    "editorBracketHighlight.foreground1" = palette.neutral-200;
    "editorBracketHighlight.foreground2" = palette.neutral-200;
    "editorBracketHighlight.foreground3" = palette.neutral-200;
    "editorBracketHighlight.foreground4" = palette.neutral-200;
    "editorBracketHighlight.foreground5" = palette.neutral-200;
    "editorBracketHighlight.foreground6" = palette.neutral-200;

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
