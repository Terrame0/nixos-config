{
  lib,
  config-add,
  ...
}:
config-add "path" {
  join-str = file-data: let
    joined-path = lib.concatStringsSep "/" (
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
  in
    joined-path;
}
