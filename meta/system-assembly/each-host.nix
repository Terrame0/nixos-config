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
      sundry.vfs.dir.load-nix
      sundry.vfs.dir.resolve-tags
    ];
    design-system =
      repo-vfs.meta.design-system."default.nix".expr
      {inherit sundry lib repo-vfs;};
    design-tokens = design-system.native-tokens;
    root-vfs =
      lib.pipe [
        {"partials{dotfiles:.design-system}" = design-system.partials-vfs;}
      ] [
        (map sundry.vfs.dir.resolve-tags)
        (lib.foldl sundry.vfs.dir.merge repo-vfs)
      ];
    meta-args = {
      inherit host inputs;
      inherit pkgs sundry lib;
      inherit design-tokens;
      inherit root-vfs;
    };
  in
    sundry.attrs.merge.recursive.no-collision [attrs-acc (f meta-args)]
) {}
(import ./hosts.nix)
