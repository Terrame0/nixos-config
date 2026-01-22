{
  lib,
  config,
  ...
}: {
  # -- duplicating this option so the package
  # -- is available in system configuration
  programs.uwsm.enable = true;
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${lib.getExe config.programs.uwsm.package} start -e -D Hyprland hyprland-uwsm.desktop";
        user = "terrame";
      };
    };
  };
}
