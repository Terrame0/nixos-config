{...}: {
  programs.alacritty = {
    enable = true;
    theme = "vscode";
    settings = {
      background_opacity = 0.85;
      window = {
        padding = {
          x = 8;
          y = 8;
        };
        dynamic_padding = true;
        opacity = 0.85;
        startup_mode = "Maximized";
        title = "Terminal";
        
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
