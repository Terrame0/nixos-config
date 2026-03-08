{
  extend-config,
  lib,
  config,
  ...
}:
extend-config "file" {
  get-spec = name: file-data:
    (lib.findFirst (spec: spec.name == name) null (config.debug file-data.new-specs)).value or null;
}
