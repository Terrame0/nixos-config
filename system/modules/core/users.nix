{
  pkgs,
  username,
  ...
}: {
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;
  users = {
    users.backup = {
      isNormalUser = true;
      description = "${username}";
      extraGroups = [
        "networkmanager"
        "wheel"
      ];
      shell = pkgs.zsh;
    };
  };
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };
}
