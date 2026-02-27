{
  lib,
  config,
  ...
}: {
  home.file = lib.listToAttrs (
    lib.forEach (lib.filesystem.listFilesRecursive ../../home-dir)
    (
      path: let
        file-data = config.fns.split-store-path path;
        file-path-str = config.fns.join-file-path (file-data // {dir = lib.tail file-data.dir;});
      in {
        name = file-path-str;
        value = {
          source = path;
        };
      }
    )
  );
}
