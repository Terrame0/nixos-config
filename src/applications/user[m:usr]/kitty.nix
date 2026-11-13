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
  programs.kitty = {
    enable = true;

    settings = {
      foreground = colors.neutral-0;
      background = colors.neutral-1000;

      selection_foreground = "none";
      selection_background = colors.neutral-600;

      cursor = colors.neutral-0;
      cursor_text_color = colors.neutral-1000;
      cursor_shape = "beam";
      cursor_blink_interval = 0;

      color0 = colors.neutral-200;
      color1 = colors.red;
      color2 = colors.green;
      color3 = colors.yellow;
      color4 = colors.blue;
      color5 = colors.purple;
      color6 = colors.aqua;
      color7 = colors.neutral-0;
      color8 = colors.neutral-200;
      color9 = colors.red;
      color10 = colors.green;
      color11 = colors.yellow;
      color12 = colors.blue;
      color13 = colors.purple;
      color14 = colors.aqua;
      color15 = colors.neutral-0;

      font_family = font.family.mono;
      font_size = 14;
      bold_font = ''full_name="${font.family.mono} Bold"'';
      bold_italic_font = ''full_name="${font.family.mono} Bold Italic"'';

      window_padding_width = 8;
      background_opacity = 1.0;
      confirm_os_window_close = 0;

      scrollback_lines = 10000;
      enable_audio_bell = false;

      shell = lib.getExe pkgs.nushell;
    };

    keybindings = {
      "ctrl+c" = "copy_to_clipboard";
      "ctrl+v" = "paste_from_clipboard";
      "ctrl+с" = "copy_to_clipboard";
      "ctrl+м" = "paste_from_clipboard";
    };

    extraConfig = ''
      map ctrl+shift+c
      map ctrl+shift+с
    '';
  };
}
