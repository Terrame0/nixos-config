{settings, ...}: let
  inherit (settings) palette;
in {
  "workbench.colorCustomizations" = {
    "editorError.foreground" = palette.red;
    "editorWarning.foreground" = palette.orange;
    "editorInfo.foreground" = palette.white;
    "editorHint.foreground" = palette.light-gray;
  };
}
