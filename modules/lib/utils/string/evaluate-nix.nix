{
  extend-config,
  config,
  lib,
  pkgs,
  flake-root,
  username,
  host,
  ...
}:
extend-config "string" {
  evaluate-nix = expression: let
    store-path = pkgs.writeText "nix-expression.nix" expression;
  in
    import store-path {
      inherit config;
      inherit lib;
      inherit pkgs;
      home-root = flake-root + "/home-dir";
      inherit username;
      inherit host;
    };
}
