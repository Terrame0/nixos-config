{
  mlem,
  lib,
  flake-root,
  ...
}: {
  home.file = lib.pipe "${flake-root}/home-manager/symlinking/home" [
    mlem.vfs.dir.from-real
    (mlem.vfs.dir.collapse (
      path: file: {"test-dir/${mlem.vfs.path.get.str path}".text = file.contents;}
    ))
    mlem.attrs.merge.recursive.no-collision
  ];
}
