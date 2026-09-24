args @ {
  host,
  sundry,
  lib,
  root,
  ...
}: let
  filter-modules = tag-value:
    lib.pipe (root + "/src") [
      sundry.vfs.dir.from-src
      (sundry.vfs.dir.filter
        (path: file: sundry.vfs.path.get.ext path == "nix"))
      sundry.vfs.dir.resolve-tags
      (sundry.vfs.dir.select-by-tag
        (e:
          (e.tag {modules = [];})
          && !(e.tag {private = [];} || e.tag {dotfiles = [];})
          && (e.tag {hosts = host.name;} || !e.tag {hosts = [];})))
      (sundry.vfs.dir.select-by-tag (e: e.deepest-tag {modules = tag-value;}))
      (sundry.vfs.dir.collapse (path: file: file.origin))
    ];
  design-system = import (root + "/meta/design-system") args;
  settings = lib.pipe (root + "/meta/settings") [
    sundry.vfs.dir.from-src
    sundry.vfs.dir.load-nix
    (sundry.vfs.dir.collapse
      (path: file: {${sundry.vfs.path.get.stem path} = file.expr args;}))
    sundry.attrs.merge.recursive.no-collision
  ];
  module-args = {
    inherit (args) inputs host sundry root;
    inherit design-system settings;
  };
in {
  specialArgs = module-args;
  modules =
    (filter-modules "system")
    ++ [
      {
        home-manager = {
          extraSpecialArgs = module-args;
          users.${host.username}.imports = filter-modules "user";
        };
      }
    ];
}
