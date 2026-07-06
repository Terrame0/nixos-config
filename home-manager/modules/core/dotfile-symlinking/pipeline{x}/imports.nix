{
  sundry,
  config-root,
  lib,
  ...
}: {
  imports = {
    transform = _: let
      dedicated-files = lib.pipe "${config-root}/home-manager/dotfile-symlinking/src" [
        sundry.vfs.dir.from-src
        sundry.vfs.dir.resolve-tags
      ];
      inline-files = lib.pipe "${config-root}/home-manager/modules" [
        sundry.vfs.dir.from-src
        sundry.vfs.dir.resolve-tags
        (sundry.vfs.dir.select-by-tag (_: with _; tag {dotfiles = [];}))
      ];
    in
      sundry.attrs.merge.recursive.no-conflict [dedicated-files inline-files];
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
