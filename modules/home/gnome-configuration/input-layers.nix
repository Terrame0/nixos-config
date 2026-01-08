{lib, ...}: {
  dconf.settings = {
    "org/gnome/desktop/input-sources" = {
      sources = [
        # -- we have to wrap this because home-manager can't
        # convert the naive implementation to a(ss) (bruh)
        (lib.hm.gvariant.mkTuple ["xkb" "us"])
        (lib.hm.gvariant.mkTuple ["xkb" "ru"])
      ];
    };

    # -- input layer switch keybind
    "org/gnome/desktop/wm/keybindings" = {
      switch-input-source = ["<Shift>Alt_L"];
      switch-input-source-backward = ["<Shift><Ctrl>Alt_L"];
    };
  };
}
