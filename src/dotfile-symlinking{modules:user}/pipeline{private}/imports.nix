{
  sundry,
  flake-file-tree,
  lib,
  ...
}: {
  dotfile-sources = {
    transform = _:
      lib.pipe flake-file-tree [
        (sundry.vfs.dir.select-by-tag (_: with _; tag {dotfiles = [];}))
        (sundry.vfs.dir.select-by-tag (e: !(e.tag {private = [];})))
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
            )))
      ];
  };
}
