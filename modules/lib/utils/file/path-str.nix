{
  lib,
  extend-config,
  ...
}:
extend-config "file" {
  path-str = file:
    lib.concatStringsSep "/" (
      file.dir
      ++ [
        (
          lib.concatStringsSep "." (
            [file.stem]
            ++ (
              lib.optional
              (file.extension != "")
              file.extension
            )
          )
        )
      ]
    );
}
