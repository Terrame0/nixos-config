{
  pkgs,
  osConfig,
  root-vfs,
  ...
}: let
  opencode = pkgs.symlinkJoin {
    name = "opencode-with-experimental";
    paths = [pkgs.opencode];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/opencode --set OPENCODE_EXPERIMENTAL_LSP_TOOL true
    '';
  };
in {
  imports = [
    root-vfs.src.applications.user.opencode.config.skills.gost-report."module.nix".origin
  ];

  programs.opencode = {
    enable = true;
    package = opencode;
    context = root-vfs.src.applications.user.opencode.config."AGENTS.md".origin;
    settings = {
      autoupdate = false;
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
