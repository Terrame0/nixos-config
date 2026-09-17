{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = [inputs.nixos-update-script.packages.${pkgs.stdenv.hostPlatform.system}.default];
}
