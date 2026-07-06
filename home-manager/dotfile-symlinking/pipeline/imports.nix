{
  sundry,
  config-root,
  lib,
  ...
}: {
  imports = {
    transform = _:
      lib.pipe "${config-root}/home-manager/dotfile-symlinking/src" [
        sundry.vfs.dir.from-src
        sundry.vfs.dir.resolve-tags
        (sundry.vfs.dir.reform-within-tag
          (_: with _; tag {"~" = [];})
          (path: file: {
            path =
              sundry.vfs.file.fold-tags (path-acc: tags: pos: let
                path-fragment =
                  if tags ? "~"
                  then lib.splitString "|" tags."~"
                  else [];
                path-cut =
                  if path-fragment == []
                  then path-acc
                  else sundry.list.remove-at pos path-acc;
              in
                sundry.list.insert-at pos path-fragment path-cut)
              path
              file;
            value = file;
          }))
      ];
  };

  processed-imports = {
    deps = ["imports"];
    transform = prev:
      lib.pipe prev.imports [
        (sundry.vfs.dir.select-by-tag
          (e:
            !(
              e.tag {include = [];}
              || e.tag {build = [];}
              || e.tag {convert = [];}
              || e.tag {x = [];}
            )))
      ];
  };
}
