{
  lib,
  config-add,
  config,
  pkgs,
  ...
}:
config-add "string" {
  evaluate-nix = expression: let
    store-path = pkgs.writeText "nix-expression.nix" expression;
  in
    import store-path {
      inherit config;
      inherit pkgs;
      inherit lib;
    };
}
