meta-args @ {
  host,
  sundry,
  lib,
  inputs,
  flake-file-tree,
  ...
}: let
  discovered-modules = lib.pipe flake-file-tree.src [
    (sundry.vfs.tree.filter (path: file: sundry.vfs.path.get.ext path == "nix"))
    (sundry.vfs.tree.select-by-tag
      (e:
        (e.tag {"m" = [];})
        && !(e.tag {"m" = "-";} || e.tag {"x" = [];} || e.tag {"dot" = [];})
        && (e.deepest-tag {"h" = host.name;} || !e.tag {"h" = [];})))
  ];
  filter-modules = tag-value:
    lib.pipe discovered-modules [
      (sundry.vfs.tree.select-by-tag (e: e.deepest-tag {"m" = tag-value;}))
      (sundry.vfs.tree.collapse (path: file: file.origin))
    ];
  module-args = removeAttrs meta-args ["pkgs" "lib"];
in {
  specialArgs = module-args;
  modules =
    (filter-modules "sys")
    ++ [
      {
        home-manager = {
          extraSpecialArgs = module-args;
          users.${host.username}.imports = filter-modules "usr";
        };
      }
    ];
}
