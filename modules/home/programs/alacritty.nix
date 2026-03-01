{config, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        transparent_background_colors = false;

        primary = {
          foreground = config.palette.foreground;
          background = config.palette.background;
        };

        search = {
          matches = {
            foreground = config.palette.background;
            background = config.palette.yellow;
          };
          focused_match = {
            foreground = config.palette.background;
            background = config.palette.green;
          };
        };

        line_indicator = {
          foreground = "None";
          background = config.palette.selection;
        };

        footer_bar = {
          foreground = config.palette.blue;
          background = config.palette.selection;
        };

        selection = {
          text = "CellForeground";
          background = config.palette.selection;
        };

        normal = {
          black = config.palette.background;
          red = config.palette.red;
          green = config.palette.green;
          yellow = config.palette.yellow;
          blue = config.palette.blue;
          magenta = config.palette.purple;
          cyan = config.palette.aqua;
          white = config.palette.foreground;
        };

        bright = {
          black = config.palette.comment;
          red = config.palette.red;
          green = config.palette.green;
          yellow = config.palette.yellow;
          blue = config.palette.blue;
          magenta = config.palette.purple;
          cyan = config.palette.aqua;
          white = config.palette.foreground;
        };
      };

      window = {
        padding = {
          x = 8;
          y = 8;
        };
        dynamic_padding = true;
        opacity = config.style.background-opacity;
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
          family = config.style.font.mono;
          style = "Regular";
        };
        bold = {
          family = config.style.font.mono;
          style = "Bold";
        };
        italic = {
          family = config.style.font.mono;
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
