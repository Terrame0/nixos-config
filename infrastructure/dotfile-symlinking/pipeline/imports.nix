{
  sundry,
  config-root,
  lib,
  ...
}: {
  imports = {
    transform = _:
      lib.pipe config-root [
        sundry.vfs.dir.from-src
        sundry.vfs.dir.resolve-tags
        (sundry.vfs.dir.select-by-tag (_: with _; tag {dotfiles = [];}))
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
              || e.tag {parts = [];}
            )))
      ];
  };
}
