{ lib, ... }:
{
  home.username = "terrame";
  home.homeDirectory = "/home/terrame";
  home.stateVersion = "25.05";

  xdg.enable = true;

  imports = lib.filter (path: lib.hasSuffix ".nix" (toString path)) (
    lib.filesystem.listFilesRecursive ../../modules/home
  );
}
