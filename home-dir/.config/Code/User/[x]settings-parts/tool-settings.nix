{...}: {
  "mesonbuild.configureOnOpen" = true;
  "mesonbuild.buildFolder" = "build";
  "mesonbuild.downloadLanguageServer" = false;

  # ============================================================
  # -- fixing inconsistent integrated terminal environment
  # ============================================================

  "terminal.integrated.inheritEnv" = false;
  "C_Cpp.default.includePath" = [];

  # ============================================================
  # -- clangd settings
  # ============================================================

  "clangd.path" = "clangd";
  "clangd.trace" = "/tmp/clangd-log.txt";
  "clangd.arguments" = [
    "--background-index"
    "--clang-tidy"
    "--header-insertion=iwyu"
    "--completion-style=detailed"
    "--log=verbose"
  ];

  # ============================================================
  # -- nix language server integration
  # ============================================================

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
