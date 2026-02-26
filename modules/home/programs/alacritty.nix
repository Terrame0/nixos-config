{pkgs,...}: let
  colors = {
    foreground = "#c5c8c6";
    background = "#1d1f21";
    selection = "#373b41";
    line = "#282a2e";
    comment = "#969896";
    red = "#d54e53";
    orange = "#e78c45";
    yellow = "#e7c547";
    green = "#b9ca4a";
    aqua = "#70c0b1";
    blue = "#7aa6da";
    purple = "#c397d8";
  };
in {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        transparent_background_colors = false;

        primary = {
          foreground = colors.foreground;
          background = pkgs.palette.red;
        };

        search = {
          matches = {
            foreground = colors.background;
            background = colors.yellow;
          };
          focused_match = {
            foreground = colors.background;
            background = colors.green;
          };
        };

        line_indicator = {
          foreground = "None";
          background = colors.selection;
        };

        footer_bar = {
          foreground = colors.blue;
          background = colors.selection;
        };

        selection = {
          text = "CellForeground";
          background = colors.selection;
        };

        normal = {
          black = colors.background;
          red = colors.red;
          green = colors.green;
          yellow = colors.yellow;
          blue = colors.blue;
          magenta = colors.purple;
          cyan = colors.aqua;
          white = colors.foreground;
        };

        bright = {
          black = colors.comment;
          red = colors.red;
          green = colors.green;
          yellow = colors.yellow;
          blue = colors.blue;
          magenta = colors.purple;
          cyan = colors.aqua;
          white = colors.foreground;
        };
      };

      window = {
        padding = {
          x = 8;
          y = 8;
        };
        dynamic_padding = true;
        opacity = 0.7;
        startup_mode = "Maximized";
        title = "Terminal";
        blur = true;
      };

      #keyboard.bindings = [
      #  {
      #    key = "C";
      #    mods = "Control|Shift";
      #    action = "Copy";
      #  }
      #  {
      #    key = "V";
      #    mods = "Control|Shift";
      #    action = "Paste";
      #  }
      #  {
      #    key = "С";
      #    mods = "Control|Shift";
      #    action = "Copy";
      #  }
      #  {
      #    key = "М";
      #    mods = "Control|Shift";
      #    action = "Paste";
      #  }
      #];

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
