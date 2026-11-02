{
  inputs,
  host,
  config,
  ...
}: {
  imports = [inputs.nixos-cli.nixosModules.nixos-cli];
  programs.nixos-cli = {
    enable = true;
    package =
      inputs.nixos-cli.packages.${host.system}.nixos-cli.override
      {nix = config.nix.package;};
    activation-interface.enable = true;
    settings = {
      config_location = "/home/${host.username}/nixos-config";
      apply = {
        reexec_as_root = true;
        use_nom = true;
      };
      differ = {
        tool = "internal";
        query_derivations = true;
      };
    };
  };
}
