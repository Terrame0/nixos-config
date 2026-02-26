{
  description = "my nixos config flake";

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
    lib = nixpkgs.lib;
    username = "terrame";
    hosts = [
      {
        name = "desktop";
        system-state-version = "25.05";
      }
      {
        name = "laptop";
        system-state-version = "25.11";
      }
    ];
    target-system = "x86_64-linux";
  in {
    nixosConfigurations = lib.fold (acc: x: acc // x) {} (
      lib.forEach hosts (host: let
        module-args = {
          inherit nixos-update-script;
          inherit nix4vscode;
          inherit username;
          inherit host;
          config-add = namespace: value: let
            path = lib.splitString "." namespace;
          in {
            options = lib.setAttrByPath path (lib.mkOption {
              type = lib.types.anything;
            });
            config = lib.setAttrByPath path value;
          };
        };
      in {
        ${host.name} = lib.nixosSystem {
          system = target-system;
          specialArgs = module-args;
          modules = [
            ./core/configuration.nix
            ./core/${"hardware-configuration@${host.name}.nix"}
            sops-nix.nixosModules.sops
            home-manager.nixosModules.home-manager
            {
              home-manager.extraSpecialArgs = module-args;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "hm-backup";
              home-manager.users.${username} = import ./core/home-configuration.nix;
            }
          ];
        };
      })
    );
  };
}
