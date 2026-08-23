{username, ...}: {
  programs.nixos-cli = {
    enable = true;
    settings.config_location = "/home/${username}/nixos-config";
  };
}
