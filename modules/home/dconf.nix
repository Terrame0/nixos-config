{...}: {
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      sources = [
        ["xkb" "us"]
        ["xkb" "ru"]
      ];
      xkb-options = ["grp:shift_space_toggle"];
      show-all-sources = true;
    };

    # -- appearance
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita";
      icon-theme = "Adwaita";
      font-name = "Adwaita Sans 11";
      accent-color = "blue";
      show-battery-percentage = true;
      enable-hot-corners = false;
      locate-pointer = false;
      toolkit-accessibility = false;
    };

    "org/gnome/desktop/session" = {
      idle-delay = 0; # -- never turn off
    };

    # -- window related options
    "org/gnome/mutter" = {
      overlay-key = "Super_L";
      dynamic-workspaces = true;
      edge-tiling = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      focus-mode = "mouse";
      button-layout = "appmenu:minimize,maximize,close";
    };

    # -- alt-tab tweaks
    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };

    # -- mouse
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat"; # -- no acceleration
      speed = 0.0; # -- default speed
    };

    # -- touchpad
    "org/gnome/desktop/peripherals/touchpad" = {
      accel-profile = "default"; # -- acceleration enabled
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
      natural-scroll = false;
      edge-scrolling-enabled = true;
    };

    # -- keybind loading
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/terminal/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/files/"
      ];
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
