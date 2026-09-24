{
  root,
  inputs,
}: f:
builtins.foldl' (
  attrs-acc: host: let
    pkgs = import inputs.nixpkgs {inherit (host) system;};
    sundry = inputs.sundry-input.mk-lib {inherit pkgs;};
    inherit (pkgs) lib;
    meta-args = {
      inherit host;
      inherit root inputs;
      inherit pkgs sundry lib;
    };
  in
    sundry.attrs.merge.recursive.no-collision [attrs-acc (f meta-args)]
) {}
(import ./hosts.nix)
