{
  config-root,
  module-args,
  username,
  host,
  sundry,
  lib,
  ...
}: let
  filter-modules = tag-value:
    lib.pipe config-root [
      sundry.vfs.dir.from-src
      (sundry.vfs.dir.filter
        (path: file: sundry.vfs.path.get.ext path == "nix"))
      sundry.vfs.dir.resolve-tags
      (sundry.vfs.dir.select-by-tag
        (e:
          (e.tag {modules = [];})
          && !(e.tag {parts = [];} || e.tag {dotfiles = [];})
          && (e.tag {hosts = host.name;} || !e.tag {hosts = [];})))
      (sundry.vfs.dir.select-by-tag (e: e.deepest-tag {modules = tag-value;}))
      (sundry.vfs.dir.collapse (path: file: file.origin))
    ];
in {
  specialArgs = module-args;
  modules =
    (filter-modules "system")
    ++ [
      {
        home-manager = {
          extraSpecialArgs = module-args;
          users.${username}.imports = filter-modules "user";
        };
      }
    ];
}
