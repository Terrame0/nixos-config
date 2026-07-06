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
              in
                if path-fragment == []
                then path-acc
                else path-fragment ++ lib.drop (pos + 1) path-acc)
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
