{lib, ...}: let
  config-path = ./configurations;
  entries =
    if builtins.pathExists config-path
    then builtins.readDir config-path
    else {};
  config-files =
    lib.filterAttrs (key: value: value != null)
    (lib.mapAttrs
      (
        name: type:
          if type == "directory"
          then {
            source = config-path + "/${name}";
            recursive = true;
          }
          else if type == "regular"
          then {
            source = config-path + "/${name}";
            recursive = false;
          }
          else null
      )
      entries);
in {
  xdg.configFile = config-files;
}
