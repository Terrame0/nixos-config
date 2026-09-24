{
  inputs,
  host,
  ...
}: {
  imports = [inputs.nixos-cli.nixosModules.nixos-cli];
  programs.nixos-cli = {
    enable = true;
    settings.config_location = "/home/${host.username}/nixos-config";
  };
}
