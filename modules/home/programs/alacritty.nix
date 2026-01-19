{...}: {
  # for #d7dad8
  # cm #a7a8a7
  # red #d77c79
  # ora #e6a472
  # yel #f4cf86
  # gre #c2c77b
  # aqu #9ac9c4
  # blu #92b2ca
  # pur #c0a7c7
  #
  # sel #474c52
  # cur #35383c
  # bg #27292c
  programs.alacritty = {
    enable = true;
    theme = "vscode";
    settings = {
      colors = {
        transparent_background_colors = true;
        primary = {
          foreground = "#d7dad8";
          background = "#27292c";
        };
        search = {
          matches = {
            foreground = "#a7a8a7";
            background = "#474c52";
          };
          focused_match = {
            foreground = "#d7dad8";
            background = "#474c52";
          };
        };
        line_indicator = {
          foreground = "#d7dad8";
          background = "#474c52";
        };
        footer_bar = {
          foreground = "#d7dad8";
          background = "#474c52";
        };
        selection = {
          foreground = "#d7dad8";
          background = "#474c52";
        };
        normal = {
          black = "#27292c";
          red = "#d77c79";
          green = "#c2c77b";
          yellow = "#f4cf86";
          blue = "#92b2ca";
          magenta = "#c0a7c7";
          cyan = "#9ac9c4";
          white = "#d7dad8";
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
