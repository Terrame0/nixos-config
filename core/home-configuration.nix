{
  lib,
  username,
  host,
  ...
}: {
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = host.system-state-version;
  xdg.enable = true;
  imports = lib.filter (path: lib.hasSuffix ".nix" (toString path)) (
    lib.filesystem.listFilesRecursive ../modules/home
  );
}
