{
  inputs,
  username,
  ...
}: {
  imports = [inputs.nixos-cli.nixosModules.nixos-cli];
  programs.nixos-cli = {
    enable = true;
    settings.config_location = "/home/${username}/nixos-config";
  };
}
