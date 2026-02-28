{
  lib,
  config-add,
  ...
}:
config-add "file" {
  path-str = file-data:
    lib.concatStringsSep "/" (
      file-data.dir
      ++ [
        (
          lib.concatStringsSep "." (
            [file-data.stem]
            ++ (
              lib.optional
              (file-data.extension != null)
              file-data.extension
            )
          )
        )
      ]
    );
}
