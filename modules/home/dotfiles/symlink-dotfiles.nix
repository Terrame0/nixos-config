{lib, ...}: let
  config-path = ./configurations;
    config-directories =
      if builtins.pathExists config-path then
      lib.filterAttrs
      (_: type: type == "directory")
      (builtins.readDir config-path)
      else {};
in {
  xdg.configFile =
    lib.mapAttrs
    (name: _: {
      source = ./config/${name};
      recursive = true;
    })
    config-directories;
}
