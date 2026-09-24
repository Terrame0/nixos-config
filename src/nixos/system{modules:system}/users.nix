{
  pkgs,
  host,
  config,
  ...
}: {
  programs.zsh.enable = true;
  users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users = {
      ${host.username} = {
        isNormalUser = true;
        description = "${host.username}";
        hashedPasswordFile =
          config.sops.secrets."password-hashes/${host.username}".path;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };
      root = {
        hashedPasswordFile =
          config.sops.secrets."password-hashes/root".path;
      };
    };
  };
}
