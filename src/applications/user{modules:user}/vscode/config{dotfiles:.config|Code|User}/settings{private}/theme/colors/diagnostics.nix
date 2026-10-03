{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.colors.base;
in {
  "workbench.colorCustomizations" = {
    "editorError.foreground" = palette.red;

    "editorHint.foreground" = palette.light-gray;

    "editorInfo.foreground" = palette.white;

    "editorWarning.foreground" = palette.orange;

    "errorForeground" = palette.red;

    "inputValidation.errorBackground" = palette.dark-gray;
    "inputValidation.errorBorder" = palette.red;
    "inputValidation.errorForeground" = palette.white;
    "inputValidation.infoBackground" = palette.dark-gray;
    "inputValidation.infoBorder" = palette.blue;
    "inputValidation.infoForeground" = palette.white;
    "inputValidation.warningBackground" = palette.dark-gray;
    "inputValidation.warningBorder" = palette.orange;
    "inputValidation.warningForeground" = palette.white;
  };
}
