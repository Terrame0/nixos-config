{
  sundry,
  root-vfs,
  lib,
  ...
}: {
  dotfile-sources = {
    transform = _:
      sundry.vfs.dir.select-by-tag (_: with _; tag {dotfiles = [];}) root-vfs;
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
              || e.tag {private = [];}
            )))
      ];
  };
}
