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
    nix-mlem = {
      url = "git+ssh://git@github.com/Terrame0/nix-mlem.git";
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
    nix-mlem,
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
        mlem = (nix-mlem.evaluate sys-attrs).functions;
        config-root = self.outPath;
        lib = pkgs.lib;
        module-args = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit config-root;
          inherit mlem;
          extend-config = namespace: value: let
            path = lib.splitString "." namespace;
          in {
            options = lib.setAttrByPath path (lib.mkOption {
              type = lib.types.anything;
            });
            config = lib.setAttrByPath path value;
          };
        };
        filter-modules = dir:
          with mlem;
            lib.pipe dir [
              vfs.dir.from-src
              (vfs.dir.resolve-tags {strip = false;})
              (vfs.dir.filter (path: file: let
                merged-tags = mlem.attrs.merge.concat file.tags;
              in
                !(merged-tags ? x)
                && mlem.list.is-in (merged-tags.hosts or host.name) host.name
                && vfs.path.get.ext path == "nix"))
              vfs.dir.path-strs
              (map (path: vfs.path.get.str [dir path]))
            ];
        lib-modules = filter-modules ./lib;
        system-modules = filter-modules ./system/modules ++ lib-modules;
        home-manager-modules = filter-modules ./home-manager/modules ++ lib-modules;
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
