{
  lib,
  extend-config,
  config,
  pkgs,
  flake-root,
  ...
}:
extend-config "string" {
  evaluate-nix = expression: let
    store-path = pkgs.writeText "nix-expression.nix" expression;
  in
    import store-path {
      home-root = flake-root + "/home-dir";
      inherit config;
      inherit pkgs;
      inherit lib;
    };
}
