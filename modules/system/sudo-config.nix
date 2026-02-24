{ ... }:
{
  # -- makes it so that ssh keys are available when running under sudo
  security.sudo.extraConfig = ''
    Defaults env_keep += "SSH_AUTH_SOCK"
  '';
}
