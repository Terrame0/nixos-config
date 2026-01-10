{
  description = "nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    zapret-discord-youtube.url = "github:kartavkun/zapret-discord-youtube";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs"; # -- make home manager use the above nixpkgs url
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    zapret-discord-youtube,
    ...
  }: {
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # -- base config files
        ./hosts/laptop/configuration.nix
        ./hosts/laptop/hardware-configuration.nix
        # -- zapret
        zapret-discord-youtube.nixosModules.default
        {
          services.zapret-discord-youtube = {
            enable = true;
            config = "general";
          };
        }
        # -- home manager
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
