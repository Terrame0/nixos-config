{
  lib,
  config-add,
  ...
}:
config-add "path" {
  join = file-data: let
    joined-path = lib.concatStringsSep "/" (
      file-data.dir
      ++ [
        (
          lib.concatStringsSep "." (
            [file-data.name]
            ++ (
              lib.optional
              (file-data.extension != "")
              file-data.extension
            )
          )
        )
      ]
    );
  in
    joined-path;
}
