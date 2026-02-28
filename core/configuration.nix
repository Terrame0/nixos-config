{
  lib,
  host,
  ...
}: {
  imports = lib.filter (path: lib.hasSuffix ".nix" (toString path)) (
    (lib.filesystem.listFilesRecursive ../modules/system)
    ++ (lib.filesystem.listFilesRecursive ../modules/lib)
  );
  system.stateVersion = host.system-state-version;
  networking.hostName = host.name;
}
