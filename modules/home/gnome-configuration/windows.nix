{...}: {
  dconf.settings = {
    # -- workspace
    "org/gnome/mutter" = {
      overlay-key = "Super_L";
      dynamic-workspaces = true;
      edge-tiling = true;
    };

    # -- misc
    "org/gnome/desktop/wm/preferences" = {
      audible-bell = false;
      focus-mode = "click";
      button-layout = "appmenu:minimize,maximize,close";
    };

    # -- alttab tweak
    "org/gnome/shell/app-switcher" = {
      current-workspace-only = true;
    };
  };
}
