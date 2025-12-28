{
  description = "nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs"; # -- make home manager use the above nixpkgs url
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./hosts/laptop/configuration.nix
        ./hosts/laptop/hardware-configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.terrame = import ./home/terrame/home.nix;
        }
      ];
    };
  };
}
