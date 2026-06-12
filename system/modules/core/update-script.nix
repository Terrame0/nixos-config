{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [
    inputs.nixos-update-script.packages.${pkgs.system}.default
  ];
}
