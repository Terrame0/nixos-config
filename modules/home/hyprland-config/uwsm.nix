{...}: {
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = {
        prettyName = "[Hyprland]";
        comment = "[Hyprland managed by UWSM]";
        binPath = "/run/current-system/sw/bin/start-hyprland";
      };
    };
  };
}
