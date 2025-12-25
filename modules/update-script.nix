{ pkgs, ... }:

{
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "system-update" ''
      #!/usr/bin/env bash
      cd /etc/nixos
      git add .
      if (sudo nixos-rebuild test --flake) then
        GEN=$(nixos-rebuild list-generations | grep "current" | awk '{print $1}')
        echo GEN 
      
    '')
  ];
}
