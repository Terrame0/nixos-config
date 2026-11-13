{
  design-tokens,
  sundry,
  ...
}: let
  palette = builtins.mapAttrs (_: color: sundry.str.slice [7] color) design-tokens.palette;
in {
  "workbench.colorCustomizations" = {
    "editorError.foreground" = palette.red;

    "editorHint.foreground" = palette.neutral-200;

    "editorInfo.foreground" = palette.neutral-0;

    "editorWarning.foreground" = palette.orange;

    "errorForeground" = palette.red;

    "inputValidation.errorBackground" = palette.neutral-800;
    "inputValidation.errorBorder" = palette.red;
    "inputValidation.errorForeground" = palette.neutral-0;
    "inputValidation.infoBackground" = palette.neutral-800;
    "inputValidation.infoBorder" = palette.blue;
    "inputValidation.infoForeground" = palette.neutral-0;
    "inputValidation.warningBackground" = palette.neutral-800;
    "inputValidation.warningBorder" = palette.orange;
    "inputValidation.warningForeground" = palette.neutral-0;
  };
}
