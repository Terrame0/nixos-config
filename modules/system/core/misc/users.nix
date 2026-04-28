{
  pkgs,
  username,
  ...
}: {
  programs.zsh.enable = true;
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = [];
    shell = pkgs.zsh;
  };
}
