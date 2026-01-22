{lib,...}: {
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      hyprland = {
        prettyName = lib.mkForce "[Hyprland]";
        comment = lib.mkForce "[Hyprland managed by UWSM]";
        binPath = lib.mkForce "/run/current-system/sw/bin/start-hyprland";
      };
    };
  };
}
