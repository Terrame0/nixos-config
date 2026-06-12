{lib, ...}: {
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = {
        prettyName = "hyprland";
        binPath = lib.mkForce "/run/current-system/sw/bin/start-hyprland";
      };
    };
  };
}
