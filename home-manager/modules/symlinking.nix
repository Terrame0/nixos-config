{
  mlem,
  lib,
  flake-root,
  ...
}: {
  home.file =
    lib.pipe
    (mlem.attrs.resolve-deps {
      imported = {
        transform = _:
          mlem.vfs.dir.from-src "${flake-root}/home-manager/symlinking/home";
      };
      specs-resolved-stripped = {
        deps = ["imported"];
        transform = prev: mlem.vfs.dir.resolve-specs {strip = true;} prev.imported;
      };
      specs-resolved = {
        deps = ["imported"];
        transform = prev: mlem.vfs.dir.resolve-specs {strip = false;} prev.imported;
      };
      sass-includes = {
        deps = ["specs-resolved-stripped"];
        transform = prev: let
          dir = prev.specs-resolved-stripped;
        in
          mlem.vfs.dir.graft-by-spec {i = "sass";} dir;
      };
    })
    [
      (mlem.vfs.dir.collapse (
        path: file: {"test-dir/${mlem.vfs.path.get.str path}".text = file.contents;}
      ))
      mlem.attrs.merge.recursive.no-collision
    ];
}
