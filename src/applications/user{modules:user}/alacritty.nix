{settings, ...}: let
  inherit (settings) palette font;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        transparent_background_colors = false;

        primary = {
          foreground = palette.white;
          background = palette.black;
        };

        search = {
          matches = {
            foreground = palette.black;
            background = palette.yellow;
          };
          focused_match = {
            foreground = palette.black;
            background = palette.green;
          };
        };

        line_indicator = {
          foreground = "None";
          background = palette.dim-gray;
        };

        footer_bar = {
          foreground = palette.blue;
          background = palette.dim-gray;
        };

        selection = {
          text = "CellForeground";
          background = palette.dim-gray;
        };

        normal = {
          black = palette.light-gray;
          red = palette.red;
          green = palette.green;
          yellow = palette.yellow;
          blue = palette.blue;
          magenta = palette.purple;
          cyan = palette.aqua;
          white = palette.white;
        };

        bright = {
          black = palette.light-gray;
          red = palette.red;
          green = palette.green;
          yellow = palette.yellow;
          blue = palette.blue;
          magenta = palette.purple;
          cyan = palette.aqua;
          white = palette.white;
        };
      };

      window = {
        padding = {
          x = 8;
          y = 8;
        };
        dynamic_padding = true;
        opacity = 1.0;
        startup_mode = "Maximized";
        title = "Terminal";
        blur = true;
      };

      keyboard.bindings = [
        {
          key = "C";
          mods = "Control";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Control";
          action = "Paste";
        }
        {
          key = "С";
          mods = "Control";
          action = "Copy";
        }
        {
          key = "М";
          mods = "Control";
          action = "Paste";
        }
      ];

      font = {
        normal = {
          family = font.mono;
          style = "Regular";
        };
        bold = {
          family = font.mono;
          style = "Bold";
        };
        italic = {
          family = font.mono;
          style = "Italic";
        };
        size = 14.0;
      };

      cursor = {
        style = {
          shape = "Beam";
          blinking = "Off";
        };
      };
    };
  };
}
