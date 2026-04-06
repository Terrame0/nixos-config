{
  extend-config,
  config,
  lib,
  ...
}:
extend-config "home-dir.files" {
  glob-includes = files: let
    path-attrset =
      lib.foldl (
        path-attrset-acc: file: let
          include-specs =
            lib.filter (spec: spec.name == "i")
            file.specs;
          spec-attrset =
            lib.foldl (
              spec-attrset-acc: spec: let
                dir = lib.take (spec.index + 1) file.dir;
              in
                spec-attrset-acc
                // {
                  ${spec.value} =
                    [(lib.concatStringsSep "/" dir)]
                    ++ (spec-attrset-acc.${spec.value} or []);
                }
            ) {}
            include-specs;
        in
          config.attrset.list-merge
          (lhs: rhs: lib.unique (lhs ++ rhs))
          path-attrset-acc
          spec-attrset
      ) {}
      (lib.filter (file: file.specs != []) files);
  in
    path-attrset;
}
