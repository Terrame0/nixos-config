{...}: {
  "nix.enableLanguageServer" = true;
  "nix.serverPath" = "nixd";
  "nix.hiddenLanguageServerErrors" = ["textDocument/definition"];
  "nix.serverSettings" = {
    "nixd" = let
      flake = "(builtins.getFlake (builtins.toString ./.))";
    in {
      "formatting" = {
        "command" = ["alejandra"];
      };
      "nixpkgs" = {
        "expr" = "import ''\${${flake}.inputs.nixpkgs}'' { system = builtins.currentSystem; }";
      };
      "options" = {
        "nixos" = {
          "expr" = "(let pkgs = import ''\${${flake}.inputs.nixpkgs}'' { system = builtins.currentSystem; }; in (pkgs.lib.evalModules { modules =  (import ''\${${flake}.inputs.nixpkgs}/nixos/modules/module-list.nix'') ++ [ ({...}: { nixpkgs.hostPlatform = builtins.currentSystem;} ) ] ; })).options";
        };
        "home_manager" = {
          "expr" = "(let pkgs = import ''\${${flake}.inputs.nixpkgs}'' { system = builtins.currentSystem; }; lib = import ''\${${flake}.inputs.home-manager}/modules/lib/stdlib-extended.nix'' pkgs.lib; in (lib.evalModules { modules =  (import ''\${${flake}.inputs.home-manager}/modules/modules.nix'') { inherit lib pkgs; check = false; }; })).options";
        };
      };
    };
  };
}
