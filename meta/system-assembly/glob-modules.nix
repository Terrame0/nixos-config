args @ {
  host,
  sundry,
  lib,
  inputs,
  root-vfs,
  ...
}: let
  filter-modules = tag-value:
    lib.pipe (sundry.vfs.dir.get ../../src root-vfs) [
      (sundry.vfs.dir.filter
        (path: file: sundry.vfs.path.get.ext path == "nix"))
      (sundry.vfs.dir.select-by-tag
        (e:
          (e.tag {modules = [];})
          && !(e.tag {private = [];} || e.tag {dotfiles = [];})
          && (e.tag {hosts = host.name;} || !e.tag {hosts = [];})))
      (sundry.vfs.dir.select-by-tag (e: e.deepest-tag {modules = tag-value;}))
      (sundry.vfs.dir.collapse (path: file: file.origin))
    ];
  settings = lib.pipe (sundry.vfs.dir.get ../settings root-vfs) [
    (sundry.vfs.dir.collapse
      (path: file: {${sundry.vfs.path.get.stem path} = file.expr args;}))
    sundry.attrs.merge.recursive.no-collision
  ];
  module-args = {
    inherit (args) inputs host sundry root-vfs;
    inherit settings;
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
