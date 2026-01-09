{...}: {
  dconf.settings = {
    # -- mouse
    "org/gnome/desktop/peripherals/mouse" = {
      accel-profile = "flat";
      speed = 0.0;
    };

    # -- touchpad
    "org/gnome/desktop/peripherals/touchpad" = {
      accel-profile = "default";
      tap-to-click = true;
      two-finger-scrolling-enabled = true;
      natural-scroll = true;
      edge-scrolling-enabled = true;
      disable-when-typing = false;
    };
  };
}
