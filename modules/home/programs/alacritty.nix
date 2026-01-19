{...}: {
  # foreground = "#c5c8c6"
  # background = "#1d1f21"
  # selection = "#373b41"
  # line = "#282a2e"
  # comment = "#969896"
  # red = "#d54e53"
  # orange = "#e78c45"
  # yellow = "#e7c547"
  # green = "#b9ca4a"
  # aqua = "#70c0b1"
  # blue = "#7aa6da"
  # purple = "#c397d8"
  # window = "#4d5057"

  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        transparent_background_colors = true;
        primary = {
          foreground = "#c5c8c6";
          background = "#1d1f21";
        };
        search = {
          matches = {
            foreground = "#f0c674";
            background = "#1d1f21";
          };
          focused_match = {
            foreground = "#f0c674";
            background = "#373b41";
          };
        };
        line_indicator = {
          foreground = "None";
          background = "#373b41";
        };
        footer_bar = {
          foreground = "#7aa6da";
          background = "#373b41";
        };
        selection = {
          text = "CellForeground";
          background = "#373b41";
        };
        bright = {
          black = "#4d5057";
          red = "#d54e53";
          green = "#b9ca4a";
          yellow = "#e7c547";
          blue = "#7aa6da";
          magenta = "#c397d8";
          cyan = "#70c0b1";
          white = "#eaeaea";
        };
        normal = {
          black = "#4d5057";
          red = "#d54e53";
          green = "#b9ca4a";
          yellow = "#e7c547";
          blue = "#7aa6da";
          magenta = "#c397d8";
          cyan = "#70c0b1";
          white = "#eaeaea";
        };
      };

      window = {
        padding = {
          x = 8;
          y = 8;
        };
        dynamic_padding = true;
        opacity = 0.85;
        startup_mode = "Maximized";
        title = "Terminal";
        blur = true;
      };

      keyboard.bindings = [
        # -- latin keybinds
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
        # -- cyrillic keybinds
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
