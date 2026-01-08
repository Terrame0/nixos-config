{...}: {
  dconf.settings = {
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
  };
}
