{
  lib,
  pkgs,
  sundry,
  design-tokens,
  ...
}: let
  inherit (design-tokens) font;
  colors =
    sundry.attrs.walk
    (path: sundry.str.slice [7])
    design-tokens.palette;
in {
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        transparent_background_colors = false;

        primary = {
          foreground = colors.neutral-0;
          background = colors.neutral-1000;
        };

        search = {
          matches = {
            foreground = colors.neutral-1000;
            background = colors.yellow;
          };
          focused_match = {
            foreground = colors.neutral-1000;
            background = colors.green;
          };
        };

        line_indicator = {
          foreground = "None";
          background = colors.neutral-600;
        };

        footer_bar = {
          foreground = colors.blue;
          background = colors.neutral-600;
        };

        selection = {
          text = "CellForeground";
          background = colors.neutral-600;
        };

        normal = {
          black = colors.neutral-200;
          red = colors.red;
          green = colors.green;
          yellow = colors.yellow;
          blue = colors.blue;
          magenta = colors.purple;
          cyan = colors.aqua;
          white = colors.neutral-0;
        };

        bright = {
          black = colors.neutral-200;
          red = colors.red;
          green = colors.green;
          yellow = colors.yellow;
          blue = colors.blue;
          magenta = colors.purple;
          cyan = colors.aqua;
          white = colors.neutral-0;
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
        dynamic_title = true;
        blur = true;
      };

      terminal.shell.program = lib.getExe pkgs.nushell;

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
          family = font.family.mono;
          style = "Regular";
        };
        bold = {
          family = font.family.mono;
          style = "Bold";
        };
        italic = {
          family = font.family.mono;
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
