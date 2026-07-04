{
  description = "my nixos config flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-update-script = {
      url = "git+ssh://git@github.com/Terrame0/nixos-update-script.git";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sundry-input = {
      url = "git+ssh://git@github.com/Terrame0/sundry.git";
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

  outputs = inputs @ {
    self,
    sops-nix,
    nixpkgs,
    home-manager,
    sundry-input,
    hyprland,
    nix4vscode,
    nixpkgs-unstable,
    nixos-update-script,
    ...
  }: let
    username = "terrame";
    hosts = [
      {
        name = "desktop";
        system-state-version = "25.05";
        system = "x86_64-linux";
      }
      {
        name = "laptop";
        system-state-version = "25.11";
        system = "x86_64-linux";
      }
    ];
  in {
    nixosConfigurations = builtins.foldl' (acc: x: acc // x) {} (
      map (host: let
        sys-attrs = {inherit (host) system;};
        pkgs = import nixpkgs sys-attrs;
        sundry = (sundry-input.evaluate sys-attrs).functions;
        config-root = self.outPath;
        lib = pkgs.lib;
        module-args = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit config-root;
          inherit sundry;
        };
        filter-modules = dir:
          lib.pipe dir [
            sundry.vfs.dir.from-src
            sundry.vfs.dir.resolve-tags
            (sundry.vfs.dir.select-by-tag
              (_: with _; !tag {x = [];} && (tag {hosts = host.name;} || !tag {hosts = [];})))
            (sundry.vfs.dir.filter (path: file: sundry.vfs.path.get.ext path == "nix"))
            (sundry.vfs.dir.collapse (path: file: file.origin))
          ];
        system-modules = filter-modules ./system/modules;
        home-manager-modules = filter-modules ./home-manager/modules;
        home-manager-config.home-manager = {
          extraSpecialArgs = module-args;
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "hm-backup";
          users.${username}.imports = home-manager-modules;
        };
        modules =
          system-modules
          ++ [
            hyprland.nixosModules.default
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            home-manager-config
          ];
      in {
        ${host.name} = nixpkgs.lib.nixosSystem {
          specialArgs = module-args;
          inherit (host) system;
          inherit modules;
        };
      })
      hosts
    );
  };
}
