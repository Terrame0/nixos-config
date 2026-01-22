{
  lib,
  pkgs,
  ...
}: {
  # -- duplicating this option so the package
  # -- is available in system configuration
  programs.uwsm.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = ''
          ${pkgs.greetd.tuigreet}/bin/tuigreet
            --time
            --remember
            --cmd "${lib.getExe pkgs.uwsm} start -e -D Hyprland hyprland-uwsm.desktop"
        '';
        user = "greeter";
      };
    };
  };
}
