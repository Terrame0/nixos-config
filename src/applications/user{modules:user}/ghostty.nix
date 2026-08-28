{
  lib,
  pkgs,
  settings,
  ...
}: let
  inherit (settings) palette font;
in {
  programs.ghostty = {
    enable = true;
    settings = {
      font-family = font.mono;
      font-family-bold = font.mono;
      font-family-italic = font.mono;
      font-style = "Regular";
      font-style-bold = "Bold";
      font-style-italic = "Italic";
      font-size = 14;

      foreground = palette.white;
      background = palette.black;
      palette = [
        "0=${palette.light-gray}"
        "1=${palette.red}"
        "2=${palette.green}"
        "3=${palette.yellow}"
        "4=${palette.blue}"
        "5=${palette.purple}"
        "6=${palette.aqua}"
        "7=${palette.white}"
        "8=${palette.light-gray}"
        "9=${palette.red}"
        "10=${palette.green}"
        "11=${palette.yellow}"
        "12=${palette.blue}"
        "13=${palette.purple}"
        "14=${palette.aqua}"
        "15=${palette.white}"
      ];

      search-foreground = palette.black;
      search-background = palette.yellow;
      search-selected-foreground = palette.black;
      search-selected-background = palette.green;
      selection-background = palette.dim-gray;

      window-padding-x = 8;
      window-padding-y = 8;
      window-padding-balance = true;
      background-opacity = 1;
      background-blur = true;
      maximize = true;

      command = "direct:${lib.getExe pkgs.nushell}";
      shell-integration = "nushell";

      keybind = [
        "performable:ctrl+c=copy_to_clipboard"
        "ctrl+v=paste_from_clipboard"
        "performable:ctrl+с=copy_to_clipboard"
        "ctrl+м=paste_from_clipboard"
      ];

      cursor-style = "bar";
      cursor-style-blink = false;
    };
  };
}
