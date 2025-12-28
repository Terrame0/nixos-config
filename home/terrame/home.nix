{...}: {
  home.username = "terrame";
  home.homeDirectory = "/home/terrame";
  home.stateVersion = "25.05";

  xdg.enable = true;

  imports = [
    ../../modules/home/user-packages.nix
    ../../modules/home/user-programs.nix
  ];
}
