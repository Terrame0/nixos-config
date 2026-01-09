{...}: {
  dconf.settings = {
    # -- keybind loading
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/"
      ];
    };

    # -- disable the <Super>v keybind to use for clipboard indicator
    "org/gnome/shell/keybindings" = {
      toggle-message-tray = ["<Super>m"];
    };

    # -- alacritty on Super+T
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal" = {
      name = "Terminal";
      command = "alacritty";
      binding = "<Super>t";
    };

    # -- file manager on Super+E
    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files" = {
      name = "Files";
      command = "nautilus";
      binding = "<Super>e";
    };

    # -- screenshot keybind
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = ["<Shift><Super>s"];
    };
  };
}
