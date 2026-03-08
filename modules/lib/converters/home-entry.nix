{
  config,
  extend-config,
  ...
}:
extend-config "convert" {
  home-entry = file: let
    file-resolved = config.file.modify file config.string.substitute-expressions;
    conversion-spec = config.file.get-spec "to" file-resolved;
    extension-spec = config.file.get-spec "ext" file-resolved;
    file-converted =
      config.chain-operations
      file-resolved
      [
        [
          (conversion-spec != null)
          (
            file-changing:
              if conversion-spec == "css"
              then config.convert.scss file-changing
              else if conversion-spec == "json" || conversion-spec == "ini"
              then config.convert.nix file-resolved
              else file-changing
          )
        ]
        [
          (extension-spec != null)
          (file-changing: file-changing // {extension = extension-spec;})
        ]
      ];
  in
    file-converted;
}
