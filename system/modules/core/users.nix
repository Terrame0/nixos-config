{
  pkgs,
  username,
  config,
  ...
}: {
  programs.zsh.enable = true;
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users = {
      ${username} = {
        isNormalUser = true;
        description = "${username}";
        hashedPasswordFile = config.sops.secrets."password-hashes/terrame".path;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };
      root = {
        hashedPasswordFile = config.sops.secrets."password-hashes/root".path;
      };
    };
  };
}
