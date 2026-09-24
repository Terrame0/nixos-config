{
  root,
  inputs,
}: f:
builtins.foldl' (
  attrs-acc: host: let
    pkgs = import inputs.nixpkgs {inherit (host) system;};
    sundry = inputs.sundry-input.mk-lib {inherit pkgs;};
    inherit (pkgs) lib;
    files-vfs = lib.pipe root [
      sundry.vfs.dir.from-src
      sundry.vfs.dir.resolve-tags
    ];
    design-system =
      import files-vfs.meta.design-system."default.nix".origin {inherit sundry lib;};
    root-vfs = sundry.vfs.dir.merge files-vfs design-system.partials-vfs;
    meta-args = {
      inherit host inputs;
      inherit pkgs sundry lib;
      inherit root-vfs;
    };
  in
    sundry.attrs.merge.recursive.no-collision [attrs-acc (f meta-args)]
) {}
(import ./hosts.nix)
