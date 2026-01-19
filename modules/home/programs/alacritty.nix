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

  # let s:foreground = "#c5c8c6"
  # let s:background = "#1d1f21"
  # let s:selection = "#373b41"
  # let s:line = "#282a2e"
  # let s:comment = "#969896"
  # let s:red = "#cc6666"
  # let s:orange = "#de935f"
  # let s:yellow = "#f0c674"
  # let s:green = "#b5bd68"
  # let s:aqua = "#8abeb7"
  # let s:blue = "#81a2be"
  # let s:purple = "#b294bb"
  # let s:window = "#4d5057"

  # -- BRIGHT
  # let s:foreground = "#eaeaea"
  # let s:background = "#000000"
  # let s:selection = "#424242"
  # let s:line = "#2a2a2a"
  # let s:comment = "#969896"
  # let s:red = "#d54e53"
  # let s:orange = "#e78c45"
  # let s:yellow = "#e7c547"
  # let s:green = "#b9ca4a"
  # let s:aqua = "#70c0b1"
  # let s:blue = "#7aa6da"
  # let s:purple = "#c397d8"
  # let s:window = "#4d5057"
  programs.alacritty = {
    enable = true;
    theme = "vscode";
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
          background = "#373b41";
        };
        footer_bar = {
          background = "#373b41";
        };
        selection = {
          background = "#373b41";
        };
        bright = {
          black = "#000000";
          red = "#d54e53";
          green = "#b9ca4a";
          yellow = "#e7c547";
          blue = "#7aa6da";
          magenta = "#c397d8";
          cyan = "#70c0b1";
          white = "#eaeaea";
        };
        normal = {
          black = "#282a2e";
          red = "#cc6666";
          green = "#b5bd68";
          yellow = "#f0c674";
          blue = "#81a2be";
          magenta = "#b294bb";
          cyan = "#8abeb7";
          white = "#c5c8c6";
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
