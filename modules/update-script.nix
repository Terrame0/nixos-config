{ pkgs, ... }:
{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "system-update" 
      (builtins.readFile ../scripts/update.sh))
  ];
}