{
  root,
  inputs,
}: f:
builtins.foldl' (
  attrs-acc: host: let
    pkgs = import inputs.nixpkgs {inherit (host) system;};
    sundry = inputs.sundry-input.mk-lib {inherit pkgs;};
    inherit (pkgs) lib;
    repo-vfs = lib.pipe root [
      sundry.vfs.dir.from-src
      sundry.vfs.dir.resolve-tags
      sundry.vfs.dir.load-nix
    ];
    design-system = repo-vfs.meta.design-system."default.nix".expr {
      inherit sundry lib;
      vfs = repo-vfs.meta.design-system;
    };
    root-vfs = sundry.vfs.dir.merge repo-vfs design-system.partials-vfs;
    meta-args = {
      inherit host inputs;
      inherit pkgs sundry lib;
      inherit root-vfs;
    };
  in
    sundry.attrs.merge.recursive.no-collision [attrs-acc (f meta-args)]
) {}
(import ./hosts.nix)
