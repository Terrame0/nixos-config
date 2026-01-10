{...}: {
  programs.alacritty = {
    enable = true;
    theme = "vscode";
    settings = {
      window = {
        padding = {
          x = 8;
          y = 8;
        };
        dynamic_padding = true;
        opacity = 0.7;
        blur = true;
        startup_mode = "Maximized";
        title = "Terminal";
      };

      bindings = [
        {
          key = "C";
          mods = "Control|Shift";
          mode = "Normal";
          action = "Copy";
        }
        {
          key = "V";
          mods = "Control|Shift";
          mode = "Normal";
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
