{...}: {
  # -- disabling systemd integration because it conflicts with uwsm
  wayland.windowManager.hyprland.systemd.enable = false;
}
