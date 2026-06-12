{
  extend-config,
  config,
  lib,
  pkgs,
  config-root,
  username,
  host,
  ...
}:
extend-config "string" {
  evaluate-nix = expression: args: let
    store-path = pkgs.writeText "nix-expression.nix" expression;
  in
    import store-path ({
        inherit config;
        inherit lib;
        inherit pkgs;
        inherit config-root;
        inherit username;
        inherit host;
      }
      // args);
}
