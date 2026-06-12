{
  extend-config,
  config-root,
  config,
  lib,
  ...
}:
extend-config "home-dir.files" {
  glob = local-path: let
    file-paths =
      lib.filesystem.listFilesRecursive
      (config.string.join-paths [config-root local-path]);
    files = lib.forEach file-paths (path: config.store-path.get-file path);
  in
    files;
}
