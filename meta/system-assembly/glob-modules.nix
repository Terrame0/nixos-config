meta-args @ {
  host,
  sundry,
  lib,
  inputs,
  flake-file-tree,
  ...
}: let
  discovered-modules = lib.pipe flake-file-tree.src [
    (sundry.vfs.tree.filter
      (path: file: sundry.vfs.path.get.ext path == "nix"))
    (sundry.vfs.tree.select-by-tag
      (e:
        (e.tag {modules = [];})
        && !(e.tag {private = [];} || e.tag {disabled = [];} || e.tag {dotfiles = [];})
        && (e.deepest-tag {hosts = host.name;} || !e.tag {hosts = [];})))
  ];
  filter-modules = tag-value:
    lib.pipe discovered-modules [
      (sundry.vfs.tree.select-by-tag (e: e.deepest-tag {modules = tag-value;}))
      (sundry.vfs.tree.collapse (path: file: file.origin))
    ];
  module-args = removeAttrs meta-args ["pkgs" "lib"];
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
