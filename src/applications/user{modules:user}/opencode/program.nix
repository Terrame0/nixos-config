{
  pkgs,
  osConfig,
  sundry,
  root,
  flake-file-tree,
  ...
}: let
  config-file-tree = sundry.vfs.dir.get-relative-to root ./config flake-file-tree;
  opencode = pkgs.symlinkJoin {
    name = "opencode-with-experimental";
    paths = [pkgs.opencode];
    nativeBuildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram $out/bin/opencode --set OPENCODE_EXPERIMENTAL_LSP_TOOL true
    '';
  };
in {
  sing-box.proxied-domains = ["deepseek.com"];
  imports = [
    config-file-tree.skills.gost-report."module.nix".origin
  ];

  programs.opencode = {
    enable = true;
    package = opencode;
    context = config-file-tree."AGENTS.md".origin;
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
