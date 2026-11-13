{
  sundry,
  flake-file-tree,
  lib,
  ...
}: {
  dotfile-sources = {
    transform = _:
      lib.pipe flake-file-tree [
        (sundry.vfs.tree.select-by-tag (_: with _; tag {"dot" = [];}))
        (sundry.vfs.tree.select-by-tag (e: !(e.tag {"m" = "-";} || e.tag {"x" = [];})))
      ];
  };

  raw-dotfiles = {
    deps = ["dotfile-sources"];
    transform = prev:
      lib.pipe prev.dotfile-sources [
        (sundry.vfs.tree.select-by-tag
          (e:
            !(
              e.tag {i = [];}
              || e.tag {mk = [];}
            )))
      ];
  };
}
