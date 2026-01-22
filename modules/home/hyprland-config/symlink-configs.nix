{ config, pkgs, ... }:
let
  config-dir = "./config";
  create_symlink = path: config.lib.file.mkOutOfStoreSymlink path;

  configs = {
    hypr = "hypr";
    rofi = "rofi";
    waybar = "waybar";
  };
in
{
  xdg.configFile = builtins.mapAttrs
    (name: subpath: {
      source = create_symlink "${config-dir}/${subpath}";
      recursive = true;
    })
    configs;
}
