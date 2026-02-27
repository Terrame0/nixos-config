{
  lib,
  config-add,
  ...
}:
config-add "fns" {
  join-file-path = file-data: let
    joined-path = lib.concatStringsSep "/" (
      file-data.dir
      ++ [
        (
          lib.concatStringsSep "." (
            [file-data.name]
            ++ (
              lib.optional
              (file-data ? extension)
              file-data.extension
            )
          )
        )
      ]
    );
  in
    lib.traceVal joined-path;
}
