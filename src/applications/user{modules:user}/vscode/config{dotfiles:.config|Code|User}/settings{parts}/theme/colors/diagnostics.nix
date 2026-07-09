{settings, ...}: let
  inherit (settings) palette;
in {
  "workbench.colorCustomizations" = {
    "editorError.foreground" = palette.red;
    "editorWarning.foreground" = palette.orange;
    "editorInfo.foreground" = palette.white;
    "editorHint.foreground" = palette.light-gray;

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
