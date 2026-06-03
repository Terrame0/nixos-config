{
  lib,
  config,
  ...
}: {
  home.file = let
    files-unfiltered = config.home-dir.phases.build config.home-dir.phases.stage;
    files =
      lib.filter
      (file: config.file.get-spec-values "x" file == [])
      files-unfiltered;
  in
    lib.listToAttrs (
      lib.forEach files
      (
        file: let
          file-path = config.file.path-str (file // {dir = lib.drop 1 file.dir;});
        in {
          name = file-path;
          value = {
            source = file.store-path;
            executable = true;
          };
        }
      )
    );
}
