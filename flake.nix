{
  description = "nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-update-script = {
      url = "path:./tools/nixos-update";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixos-update-script,
    ...
  }: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit nixos-update-script;
      };
      modules = [
        # -- base config files
        ./hosts/laptop/configuration.nix
        ./hosts/laptop/hardware-configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-backup";
          home-manager.users.terrame = import ./home/terrame/home-configuration.nix;
        }
      ];
    };
    nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      specialArgs = {
        inherit nixos-update-script;
      };
      modules = [
        ./hosts/desktop/configuration.nix
        ./hosts/desktop/hardware-configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.backupFileExtension = "hm-backup";
          home-manager.users.terrame = import ./home/terrame/home-configuration.nix;
        }
      ];
    };
  };
}
