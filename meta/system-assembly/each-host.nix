{
  root,
  inputs,
}: f:
builtins.foldl' (
  attrs-acc: host: let
    pkgs = import inputs.nixpkgs {inherit (host) system;};
    sundry = import inputs.sundry-input {inherit pkgs;};
    inherit (pkgs) lib;
    source-file-tree = lib.pipe root [
      sundry.vfs.dir.from-src
      sundry.vfs.dir.load-nix
      sundry.vfs.dir.resolve-tags
    ];
    design-system =
      source-file-tree.meta.design-system."default.nix".expr
      {inherit sundry lib source-file-tree;};
    design-tokens = design-system.native-tokens;
    flake-file-tree =
      lib.pipe [
        {"partials{dotfiles:.design-system}" = design-system.partials-file-tree;}
      ] [
        (map sundry.vfs.dir.resolve-tags)
        (lib.foldl sundry.vfs.dir.merge source-file-tree)
      ];
    meta-args = {
      inherit host inputs root;
      inherit pkgs sundry lib;
      inherit design-tokens;
      inherit flake-file-tree;
    };
  in
    sundry.attrs.merge.recursive.no-collision [attrs-acc (f meta-args)]
) {}
(import ./hosts.nix)