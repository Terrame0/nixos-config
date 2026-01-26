{lib, ...}: let
  config-directories =
    lib.filterAttrs
    (_: type: type == "directory")
    (builtins.readDir ./configurations);
in {
  xdg.configFile =
    lib.mapAttrs
    (name: _: {
      source = ./config/${name};
      recursive = true;
    })
    config-directories;
}
