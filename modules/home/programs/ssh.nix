{
  personal-ssh-key-path,
  github-ssh-key-path,
  ...
}:
{
  programs.ssh = {
    enable = true;
    # -- do not auto-inject defaults in the future
    enableDefaultConfig = false;
    matchBlocks = {
      "*" = {
        identityFile = personal-ssh-key-path;
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
        identityFile = github-ssh-key-path;
        identitiesOnly = true;
        addKeysToAgent = "yes";
      };
    };
  };
}
