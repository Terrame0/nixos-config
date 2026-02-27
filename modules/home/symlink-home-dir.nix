{
  lib,
  config,
  ...
}: {
  home.file = lib.listToAttrs (
    lib.forEach (lib.filesystem.listFilesRecursive ../../home-dir)
    (
      path: let
        file-data = config.fns.convert-home-file (config.path.get-data path);
        file-path = config.path.join (file-data // {dir = lib.tail file-data.dir;});
      in {
        name = file-path;
        value = {
          source = file-data.store-path;
        };
      }
    )
  );
}
