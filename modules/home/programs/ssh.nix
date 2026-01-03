{...}: {
  programs.ssh = {
    enable = true;
    # -- do not auto-inject defaults in the future
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        serverAliveInterval = 60;
        serverAliveCountMax = 3;
        hashKnownHosts = true;
        forwardAgent = false;
        compression = false;
      };
      "github.com" = {
        user = "git";
        identityFile = "~/.ssh/id_ed25519";
        identitiesOnly = true;
      };
    };
  };
}
