{
  sundry,
  config-root,
  design-system,
  lib,
  ...
}: {
  dotfile-sources = {
    transform = _:
      lib.pipe config-root [
        sundry.vfs.dir.from-src
        (tree:
          sundry.attrs.merge.recursive.no-collision [tree {"partials{dotfiles:.design-system}" = design-system.partials;}])
        sundry.vfs.dir.resolve-tags
        (sundry.vfs.dir.select-by-tag (_: with _; tag {dotfiles = [];}))
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
