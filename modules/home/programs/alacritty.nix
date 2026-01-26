{...}: let
  # -- color palette
  colors = {
    foreground = "#c5c8c6";
    background = "#1d1f21";
    selection-bg = "#373b41";
    line = "#282a2e";
    comment = "#969896";
    red = "#d54e53";
    orange = "#e78c45";
    yellow = "#e7c547";
    green = "#b9ca4a";
    aqua = "#70c0b1";
    blue = "#7aa6da";
    purple = "#c397d8";
    window = "#4d5057";
    white = "#eaeaea";
  };
in {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        transparent-background-colors = false;

        primary = {
          foreground = colors.foreground;
          background = colors.background;
        };

        search = {
          matches = {
            foreground = colors.foreground;
            background = colors.yellow;
          };
          focused-match = {
            foreground = colors.foreground;
            background = colors.green;
          };
        };

        line-indicator = {
          foreground = "None";
          background = colors.selection-bg;
        };

        footer-bar = {
          foreground = colors.blue;
          background = colors.selection-bg;
        };

        selection = {
          text = "CellForeground";
          background = colors.selection-bg;
        };

        bright = {
          black = colors.window;
          red = colors.red;
          green = colors.green;
          yellow = colors.yellow;
          blue = colors.blue;
          magenta = colors.purple;
          cyan = colors.aqua;
          white = colors.white;
        };

        normal = {
          black = colors.background;
          red = colors.red;
          green = colors.green;
          yellow = colors.yellow;
          blue = colors.blue;
          magenta = colors.purple;
          cyan = colors.aqua;
          white = colors.white;
        };
      };

      window = {
        padding = {
          x = 8;
          y = 8;
        };
        dynamic-padding = true;
        opacity = 0.7;
        startup-mode = "Maximized";
        title = "Terminal";
        blur = true;
      };

      keyboard-bindings = [
        {
          key = "C";
          mods = "Control|Shift";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Control|Shift";
          action = "Paste";
        }
        {
          key = "С";
          mods = "Control|Shift";
          action = "Copy";
        }
        {
          key = "М";
          mods = "Control|Shift";
          action = "Paste";
        }
      ];

      font = {
        normal = {
          family = "JetBrainsMono Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "JetBrainsMono Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "JetBrainsMono Nerd Font";
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
