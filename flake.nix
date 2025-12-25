{
  description = "laptop config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";  
  };

  outputs = { nixpkgs, ... }: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        ./hardware-configuration.nix
      ];
    };
  };
}