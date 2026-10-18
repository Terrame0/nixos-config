{
  inputs,
  host,
  ...
}: {
  imports = [inputs.nixos-cli.nixosModules.nixos-cli];
  programs.nixos-cli = {
    enable = true;
    option-cache.enable = true;
    activation-interface.enable = true;
    settings = {
      config_location = "/home/${host.username}/nixos-config";
      apply = {
        reexec_as_root = true;
        use_nom = true;
      };
      differ.query_derivations = true;
    };
  };
}
