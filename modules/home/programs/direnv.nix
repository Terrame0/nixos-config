{ ... }:
{
  programs = {
    direnv = {
      silent = true;
      enable = true;
      enableZshIntegration = true;
      nix-direnv.enable = true;
    };
  };
}
