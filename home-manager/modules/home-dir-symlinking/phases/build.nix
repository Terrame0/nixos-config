{
  extend-config,
  config,
  lib,
  ...
}:
extend-config "home-dir.phases" {
  build = {
    files,
    include-paths,
    staging-dir,
  }: let
    files-built = lib.forEach files (
      file: let
        build-specs = config.file.get-spec-values "build" file;
      in
        config.conditional-foldl
        file
        [
          [
            (build-specs != [])
            (
              file-changing:
                if
                  builtins.elem "sass" build-specs
                  && file-changing.extension == "scss"
                then config.convert.scss file-changing include-paths staging-dir
                else file-changing
            )
          ]
        ]
    );
  in
    files-built;
}
