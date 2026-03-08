{
  lib,
  extend-config,
  ...
}:
extend-config "file" {
  path-str = file-data:
    lib.concatStringsSep "/" (
      file-data.dir
      ++ [
        (
          lib.concatStringsSep "." (
            [file-data.stem]
            ++ (
              lib.optional
              (file-data.extension != "")
              file-data.extension
            )
          )
        )
      ]
    );
}
