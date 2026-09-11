{
  pkgs,
  osConfig,
  ...
}: {
  programs.opencode = {
    enable = true;
    settings = {
      autoupdate = true;
      lsp = true;
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
    extraPackages = [pkgs.uv];
  };
}
