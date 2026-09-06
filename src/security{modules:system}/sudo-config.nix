{username, ...}: {
  # -- makes it so that ssh keys are available when running under sudo
  security.sudo.extraConfig = ''
    Defaults env_keep += "SSH_AUTH_SOCK"
    Defaults env_keep += "SOPS_AGE_KEY_FILE"
    ${username} ALL=(ALL) NOPASSWD: /run/current-system/sw/bin/nixos-rebuild
  '';
}
