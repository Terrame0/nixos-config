{pkgs, ...}: {
  programs.zsh.enable = true;
  users.users.terrame = {
    isNormalUser = true;
    description = "Terrame";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = [];
    shell = pkgs.zsh;
  };
}
