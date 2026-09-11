{
  pkgs,
  config,
  ...
}: {
  programs.opencode = {
    enable = true;
    enableMcpIntegration = true;
    settings = {
      autoupdate = true;
      provider = {
        deepseekv4 = {
          npm = "@ai-sdk/anthropic";
          name = "DeepSeek";
          options = {
            baseURL = "https://api.deepseek.com/anthropic";
            apiKey = "{file:${config.sops.secrets."deepseek-api/key".path}}";
          };
          models = {
            "deepseek-v4-pro" = {
              name = "DeepSeek-V4-Pro";
              limit = {
                context = 1048576;
                output = 262144;
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
      model = "deepseekv4/deepseek-v4-pro";
    };
    extraPackages = [pkgs.uv];
  };
}
