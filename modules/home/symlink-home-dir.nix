{
  lib,
  config,
  flake-root,
  ...
}: {
  home.file = let
    file-paths = lib.filesystem.listFilesRecursive (flake-root + "/home-dir");
    unfiltered-files = lib.forEach file-paths (path: config.store-path.get-file path);
    include-paths = config.glob-includes unfiltered-files;
    files =
      lib.filter
      (file: config.file.get-spec-values "x" file == [])
      unfiltered-files;
  in
    lib.listToAttrs (
      lib.forEach files
      (
        file: let
          file-resolved = config.convert.home-entry file include-paths;
          file-path = config.file.path-str (file-resolved // {dir = lib.drop 1 file-resolved.dir;});
        in {
          name = file-path;
          value = {
            source = file-resolved.store-path;
            executable = true;
          };
        }
      )
    );
}
