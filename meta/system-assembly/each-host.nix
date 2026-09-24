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
    design-system-subtree = sundry.vfs.dir.get ../design-system repo-vfs;
    design-system = design-system-subtree."default.nix".expr {
      inherit sundry lib;
      vfs = design-system-subtree;
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
