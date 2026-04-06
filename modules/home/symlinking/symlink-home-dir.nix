{
  lib,
  config,
  ...
}: let
  preparation-phase = let
    unfiltered-files = config.directory.glob-local-files "home-dir";
    files-raw =
      lib.filter
      (file: config.file.get-spec-values "x" file == [])
      unfiltered-files;
  in {
    include-paths = config.debug (config.glob-includes unfiltered-files);
    files = lib.forEach files-raw (
      file-raw:
        config.file.modify file-raw config.string.substitute-expressions
    );
  };

  staging-phase = files: include-paths: let
    files-formed = lib.forEach files (
      file: let
        build-specs = config.file.get-spec-values "build" file;
        form-specs = config.file.get-spec-values "form" file;
        extension-specs = config.file.get-spec-values "ext" file;
      in
        config.chain-operations
        file
        [
          [
            (form-specs != null)
            (
              file-changing:
                if
                  builtins.elem "json" form-specs
                  || builtins.elem "ini" form-specs
                  && file-changing.extension == "nix"
                then config.convert.nix file
                else file-changing
            )
          ]
          [
            (build-specs != null)
            (
              file-changing:
                if
                  builtins.elem "sass" build-specs
                  && file-changing.extension == "scss"
                then config.convert.scss file-changing include-paths
                else file-changing
            )
          ]
          [
            (extension-specs != [])
            (file-changing: file-changing // {extension = lib.head extension-specs;})
          ]
        ]
    );
    files-staged = config.directory.mk-staging (lib.forEach files-formed (
      file-formed: {
        src = file-formed;
        path = config.file.path-str file-formed;
      }
    ));
  in
    files-staged;

  build-phase = files: include-paths: let in 10;
in {
  home.file = let
    prepared-files = preparation-phase.files;
    include-paths = preparation-phase.include-paths;
    files = (staging-phase prepared-files include-paths).files;
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
# staging-dir = config.directory.mk-staging "home-dir-staging" [
#   {
#     path = "bruh/a/b/c/file.txt";
#     src = lib.head files;
#   }
# ];

