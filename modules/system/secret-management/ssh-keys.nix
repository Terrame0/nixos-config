{ config, ... }:
{
  sops.templates."github-ssh-key" = {
    content = "${config.sops.placeholder."ssh-keys/github"}";
    owner = "terrame";
    group = "users";
    mode = "0400";
  };

  sops.templates."personal-ssh-key" = {
    content = "${config.sops.placeholder."ssh-keys/personal"}";
    owner = "terrame";
    group = "users";
    mode = "0400";
  };

  home-manager.extraSpecialArgs = {
    github-ssh-key-path = config.sops.templates."github-ssh-key".path;
    personal-ssh-key-path = config.sops.templates."personal-ssh-key".path;
  };
}
