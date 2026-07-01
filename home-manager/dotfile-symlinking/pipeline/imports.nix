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
