{
  extend-config,
  config,
  lib,
  ...
}:
extend-config "home-dir.phases" {
  stage = let
    # -- raw files from the in-store home directory
    files-raw = config.home-dir.files.glob "home-dir";

    # -- files with substituted expressions
    files-prepared = lib.forEach files-raw (
      file-raw: let
        file-prepared = config.file.modify file-raw config.string.substitute-expressions;
      in
        file-prepared
    );

    # -- transpiled files
    files-formed = lib.forEach files-prepared (
      file: let
        form-specs = config.file.get-spec-values "form" file;
        extension-specs = config.file.get-spec-values "ext" file;
      in
        config.conditional-foldl
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
        ]
    );

    # -- staging directory for the build phase
    # (exists to allow transpilers to ingest formed files
    #  with resolved substitutions and directories stripped of specs)
    staging-dir-attrs = config.directory.mk-staging-dir (lib.forEach files-formed (
      file-formed: {
        src = file-formed;
        path = config.file.path-str file-formed;
      }
    ));

    # -- include paths for the build phase
    include-paths = config.home-dir.files.glob-includes files-raw;
  in
    staging-dir-attrs // {inherit include-paths;};
}
