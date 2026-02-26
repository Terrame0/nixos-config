{
  description = "nixos config flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-update-script = {
      url = "git+ssh://git@github.com/Terrame0/nixos-update-script.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix4vscode = {
      url = "github:nix-community/nix4vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    nixpkgs,
    home-manager,
    nixos-update-script,
    sops-nix,
    nix4vscode,
    ...
  }: let
    username = "terrame";
    hosts = [
      "desktop"
      "laptop"
    ];
    target-system = "x86_64-linux";
    nixos-configuration-list = nixpkgs.lib.fold (acc: x: acc // x) {} (
      nixpkgs.lib.forEach hosts (current-host: let
        module-args = {
          inherit nixos-update-script;
          inherit nix4vscode;
          inherit current-host;
          inherit username;
        };
      in {
        ${current-host} = nixpkgs.lib.nixosSystem {
          system = target-system;
          specialArgs = module-args;
          modules = [
            ./hosts/${current-host}/configuration.nix
            ./hosts/${current-host}/hardware-configuration.nix
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = module-args;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-backup";
              home-manager.users.${username} = import ./home/${username}/home-configuration.nix;
            }
          ];
        };
      })
    );
  in {
    nixosConfigurations = nixos-configuration-list;
  };
}
