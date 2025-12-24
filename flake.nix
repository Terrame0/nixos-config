{
  description = "laptop config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-stable";  
  };

  outputs = { nixpkgs, ... }: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix          
      ];
    };
  };
}