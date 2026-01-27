let
  flake = builtins.getFlake (builtins.toString ./.);

  # -- nixpkgs import
  nixpkgs-expression = import flake.inputs.nixpkgs {system = builtins.currentSystem;};

  # -- nixos options
  nixos-expression = let
    configs = flake.nixosConfigurations or {};
    first-config =
      if builtins.length (builtins.attrNames configs) > 0
      then configs.${builtins.head (builtins.attrNames configs)}
      else {};
    result = builtins.tryEval (first-config.options or {});
  in
    if result.success
    then result.value
    else {};

  # -- hm options
  home-manager-expression = let
    configs = flake.homeConfigurations or {};
    first-config =
      if builtins.length (builtins.attrNames configs) > 0
      then configs.${builtins.head (builtins.attrNames configs)}
      else {};
    result = builtins.tryEval (first-config.options or {});
  in
    if result.success
    then result.value
    else {};
in {
  "nixd" = {
    "nixpkgs" = {
      "expr" = nixpkgs-expression;
    };
    "options" = {
      "nixos" = {
        "expr" = nixos-expression;
      };
      "home-manager" = {
        "expr" = home-manager-expression;
      };
    };
    "formatting" = {
      "command" = ["alejandra"];
    };
  };
}
