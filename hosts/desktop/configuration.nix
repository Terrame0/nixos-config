{lib, ...}: {
  # -- importing modules and other stuff
  imports =
    lib.filter
    (path: lib.hasSuffix ".nix" (toString path))
    (lib.filesystem.listFilesRecursive ../../modules/system);

  # -- system state version
  system.stateVersion = "25.05";

  # -- hostname
  networking.hostName = "desktop";
}
