{...}: let
  palette = {
    black = "#1d1f21";
    dark-gray = "#282a2e";
    dim-gray = "#373b41";
    gray = "#4d5057";
    light-gray = "#969896";
    white = "#c5c8c6";
    red = "#d54e53";
    orange = "#e78c45";
    yellow = "#e7c547";
    green = "#b9ca4a";
    aqua = "#70c0b1";
    blue = "#7aa6da";
    purple = "#c397d8";
  };
  font = {
    mono = "JetBrainsMono NF";
  };
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
