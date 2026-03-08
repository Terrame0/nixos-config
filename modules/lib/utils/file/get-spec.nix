{
  extend-config,
  lib,
  config,
  ...
}:
extend-config "file" {
  get-spec = name: file:
    (lib.findFirst (spec: spec.name == name) null file.specs).value or null;
}
