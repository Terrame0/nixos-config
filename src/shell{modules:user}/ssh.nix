{osConfig, ...}: {
  programs.ssh = {
    enable = true;
    # -- do not auto-inject defaults in the future
    enableDefaultConfig = false;
    settings = {
      "*" = {
        identityFile = osConfig.sops.secrets."ssh/personal-key".path;
        identitiesOnly = true;
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
        hashKnownHosts = true;
        forwardAgent = false;
        compression = false;
        addKeysToAgent = "yes";
      };
      "github.com" = {
        user = "git";
        identityFile = osConfig.sops.secrets."ssh/github-key".path;
        identitiesOnly = true;
        addKeysToAgent = "yes";
      };
    };
  };
}
