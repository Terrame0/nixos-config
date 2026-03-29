{
  extend-config,
  lib,
  ...
}:
extend-config "file" {
  get-spec-values = name: file: let
    spec-list = lib.filter (spec: spec.name == name) file.specs;
    spec-values =
      lib.foldl (
        values: attrset: values ++ [attrset.value]
      ) []
      spec-list;
  in
    spec-values;
}
