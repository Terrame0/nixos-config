{
  mlem,
  lib,
  ...
}: {
  home.file = lib.pipe ./programs [
    mlem.vfs.dir.from-real
    (mlem.vfs.dir.collapse (
      path: file: {"test-dir/${mlem.vfs.path.get.str path}".text = file.contents;}
    ))
    mlem.attrs.merge.recursive.no-collision
  ];
}
