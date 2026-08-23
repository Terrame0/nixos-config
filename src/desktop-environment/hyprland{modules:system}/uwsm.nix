{lib, ...}: {
  programs.uwsm = {
    waylandCompositors = {
      hyprland = {
        prettyName = "hyprland";
        binPath = lib.mkForce "/run/current-system/sw/bin/start-hyprland";
      };
    };
  };
}
