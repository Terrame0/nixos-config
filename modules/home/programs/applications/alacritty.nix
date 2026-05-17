{config, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        transparent_background_colors = false;

        primary = {
          foreground = config.style.palette.white;
          background = config.style.palette.black;
        };

        search = {
          matches = {
            foreground = config.style.palette.black;
            background = config.style.palette.yellow;
          };
          focused_match = {
            foreground = config.style.palette.black;
            background = config.style.palette.green;
          };
        };

        line_indicator = {
          foreground = "None";
          background = config.style.palette.dim-gray;
        };

        footer_bar = {
          foreground = config.style.palette.blue;
          background = config.style.palette.dim-gray;
        };

        selection = {
          text = "CellForeground";
          background = config.style.palette.dim-gray;
        };

        normal = {
          black = config.style.palette.light-gray;
          red = config.style.palette.red;
          green = config.style.palette.green;
          yellow = config.style.palette.yellow;
          blue = config.style.palette.blue;
          magenta = config.style.palette.purple;
          cyan = config.style.palette.aqua;
          white = config.style.palette.white;
        };

        bright = {
          black = config.style.palette.light-gray;
          red = config.style.palette.red;
          green = config.style.palette.green;
          yellow = config.style.palette.yellow;
          blue = config.style.palette.blue;
          magenta = config.style.palette.purple;
          cyan = config.style.palette.aqua;
          white = config.style.palette.white;
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
