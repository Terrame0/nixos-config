{
  config,
  extend-config,
  lib,
  ...
}:
extend-config "convert" {
  home-entry = file: include-paths: let
    file-resolved = config.file.modify file config.string.substitute-expressions;
    conversion-specs = config.file.get-spec-values "to" file-resolved;
    extension-specs = config.file.get-spec-values "ext" file-resolved;
    file-converted =
      config.chain-operations
      file-resolved
      [
        [
          (conversion-specs != null)
          (
            file-changing:
              if
                builtins.elem "css" conversion-specs
                && file-changing.extension == "scss"
              then config.convert.scss file-changing include-paths
              else if
                builtins.elem "json" conversion-specs
                || builtins.elem "ini" conversion-specs
                && file-changing.extension == "nix"
              then config.convert.nix file-resolved
              else file-changing
          )
        ]
        [
          (extension-specs != [])
          (file-changing: file-changing // {extension = lib.head extension-specs;})
        ]
      ];
  in
    file-converted;
}
