{
  lib,
  config,
  ...
}: {
  home.file = lib.listToAttrs (
    lib.forEach (lib.filesystem.listFilesRecursive ../../home-dir)
    (
      path: let
        file-data = config.store-path.get-file-data path;
        resolved-file-data = config.convert.home-entry file-data;
        file-path = config.file.path-str (resolved-file-data // {dir = lib.drop 1 resolved-file-data.dir;});
      in {
        name = file-path;
        value = {
          source = resolved-file-data.store-path;
          executable = true;
        };
      }
    )
  );
}
