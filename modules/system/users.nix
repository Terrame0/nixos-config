{pkgs, ...}: {
  # -- to use as default shell (config defined in home-manager)
  programs.zsh.enable = true;
  # -- user configuration
  users.users.terrame = {
    isNormalUser = true;
    description = "Terrame";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
    packages = [];
  };
}
