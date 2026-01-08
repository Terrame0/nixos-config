{...}: {
  dconf.settings = {
    "org/gnome/mutter" = {
      overlay-key = "Super_L";
      dynamic-workspaces = true;
      edge-tiling = true;
    };

    "org/gnome/desktop/wm/preferences" = {
      audible-bell = false;
      focus-mode = "mouse";
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };
  };
}
