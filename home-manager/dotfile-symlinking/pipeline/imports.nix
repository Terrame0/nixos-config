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
          (_: with _; tag {ext = [];})
          (path: file: {
            path = sundry.vfs.path.set.ext (lib.last file.tag-list).ext path;
            value = file;
          }))
      ];
  };

  #interpolated = {
  #  deps = ["imports"];
  #  transform = prev:
  #    lib.pipe prev.imports [
  #      (sundry.vfs.dir.walk (path: file: let
  #        modified-contents = sundry.str.apply-between "\"#{" "}\"" (string: string) file.text;
  #      in
  #        file // {text = modified-contents;}))
  #    ];
  #};

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
