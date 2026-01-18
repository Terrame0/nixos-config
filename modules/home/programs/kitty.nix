{...}: {
  programs.kitty = {
    enable = true;
    theme = "VSCode_Dark";

    settings = {
      window_padding_width = "8 8";
      resize_debounce_time = "0.1";
      background_opacity = "0.8";
      blur = true;
      font_family = "JetBrainsMono Nerd Font";
      font_size = 14.0;
      cursor_shape = "beam";
      cursor_blink_interval = 0;
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
      "ctrl+shift+v" = "paste_from_clipboard";
    };

    font = {
      package = null;
      name = "JetBrainsMono Nerd Font";
      size = 14;
    };
  };
}
