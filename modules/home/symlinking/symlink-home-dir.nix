# files-raw =
#       lib.filter
#       (file: config.file.get-spec-values "x" file == [])
#       files-unfiltered;
{
  lib,
  config,
  ...
}: let
  staging-phase = let
    files-raw = config.directory.glob-local-files "home-dir";
    files-prepared = lib.forEach files-raw (
      file-raw: let
        file-prepared = config.file.modify file-raw config.string.substitute-expressions;
      in
        file-prepared
    );
    files-formed = lib.forEach files-prepared (
      file: let
        form-specs = config.file.get-spec-values "form" file;
        extension-specs = config.file.get-spec-values "ext" file;
        file-formed =
          config.chain-operations
          file
          [
            [
              (form-specs != [])
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
              (extension-specs != [])
              (file-changing: file-changing // {extension = lib.head extension-specs;})
            ]
          ];
      in
        file-formed
    );
    staging-dir-attrs = config.directory.mk-staging (lib.forEach files-formed (
      file-formed: {
        src = file-formed;
        path = config.file.path-str file-formed;
      }
    ));
    include-paths = config.debug (config.glob-includes files-raw);
  in
    staging-dir-attrs // {inherit include-paths;};

  build-phase = {
    files,
    include-paths,
    staging-dir,
  }: let
    files-built = lib.forEach files (
      file: let
        build-specs = config.file.get-spec-values "build" file;
      in
        config.chain-operations
        file
        [
          [
            (build-specs != null)
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
in {
  home.file = let
    files = build-phase staging-phase;
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

