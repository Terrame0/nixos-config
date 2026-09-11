{
  host,
  pkgs,
  osConfig,
  ...
}: let
  config-dir = ./${"config{private}"};
  opencode = pkgs.symlinkJoin {
    name = "opencode-with-experimental";
    paths = [pkgs.opencode];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/opencode --set OPENCODE_EXPERIMENTAL_LSP_TOOL true
    '';
  };
in {
  programs.opencode = {
    enable = true;
    package = opencode;
    context = config-dir + "/AGENTS.md";
    settings = {
      autoupdate = true;
      lsp = {
        nixd = {
          command = ["${pkgs.nixd}/bin/nixd"];
          initialization.nixd = {
            nixpkgs.expr = "import (builtins.getFlake (toString ./.)).inputs.nixpkgs { }";
            options = {
              nixos.expr = "(builtins.getFlake (toString ./.)).nixosConfigurations.${host.name}.options";
              home-manager.expr = "(builtins.getFlake (toString ./.)).nixosConfigurations.${host.name}.options.home-manager.users.type.getSubOptions []";
            };
            formatting.command = ["alejandra"];
          };
        };
      };
      provider = {
        deepseek = {
          npm = "@ai-sdk/anthropic";
          name = "DeepSeek";
          options = {
            baseURL = "https://api.deepseek.com/anthropic";
            apiKey = "{file:${osConfig.sops.secrets."deepseek-api/key".path}}";
          };
          models = {
            "deepseek-flash" = {
              name = "DeepSeek V4.1 Flash";
              limit = {
                context = 1000000;
                output = 384000;
              };
              options = {
                thinking = {
                  type = "enabled";
                  budgetTokens = 8192;
                };
              };
            };
          };
        };
      };
      model = "deepseek/deepseek-flash";
    };
    extraPackages = with pkgs; [
      statix
      fd
    ];
  };
}
