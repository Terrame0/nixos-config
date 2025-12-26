{
  description = "nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";  
  };

  outputs = { nixpkgs, ... }: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/laptop/configuration.nix
        ./hosts/laptop/hardware-configuration.nix
      ];
    };
  };
}