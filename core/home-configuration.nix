{
  lib,
  username,
  host,
  ...
}: {
  imports = lib.filter (path: lib.hasSuffix ".nix" (toString path)) (
    (lib.filesystem.listFilesRecursive ../modules/home)
    ++ (lib.filesystem.listFilesRecursive ../modules/lib)
  );
  home.username = username;
  home.homeDirectory = "/home/${username}";
  home.stateVersion = host.system-state-version;
  xdg.enable = true;
}
