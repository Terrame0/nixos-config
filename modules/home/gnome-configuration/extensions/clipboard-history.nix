{...}: {
  dconf.settings = {
    "org/gnome/shell/extensions/clipboard-indicator" = {
      cache-only-favorites = true;
      clear-on-boot = true;
      confirm-clear = false;
      display-mode = 0;
      keep-selected-on-clear = true;
      move-item-first = false;
      notify-on-cycle = false;
      paste-button = true;
      paste-on-select = true;
      pinned-on-bottom = true;
      strip-text = true;
      private-mode-binding = [];
      next-entry = [];
      prev-entry = [];
      clear-history = [];
      toggle-menu = ["<Super>v"];
    };
  };
}
