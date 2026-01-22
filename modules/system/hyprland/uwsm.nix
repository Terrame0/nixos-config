{...}: {
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = {
        binPath = "/run/current-system/sw/bin/start-hyprland";
      };
    };
  };
}
