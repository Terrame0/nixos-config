{
  sundry,
  config-root,
  lib,
  ...
}: {
  dotfile-sources = {
    transform = _:
      lib.pipe config-root [
        sundry.vfs.dir.from-src
        sundry.vfs.dir.resolve-tags
        (sundry.vfs.dir.select-by-tag (_: with _; tag {dotfiles = [];}))
        sundry.debug
      ];
  };

  raw-dotfiles = {
    deps = ["dotfile-sources"];
    transform = prev:
      lib.pipe prev.dotfile-sources [
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
