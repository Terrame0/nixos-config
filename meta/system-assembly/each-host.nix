inputs: f:
builtins.foldl' (
  attrs-acc: host: let
    config-root = inputs.self.outPath;
    meta-root = config-root + "/meta";
    src-root = config-root + "/src";
    pkgs = import inputs.nixpkgs {inherit (host) system;};
    sundry = inputs.sundry-input.mk-lib {inherit pkgs;};
    inherit (pkgs) lib;
    meta-args = {
      inherit host inputs;
      inherit config-root meta-root src-root;
      inherit pkgs sundry lib;
    };
  in
    sundry.attrs.merge.recursive.no-collision [attrs-acc (f meta-args)]
) {}
(import ./hosts.nix)
