{
  description = "my nixos config flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland = {
      url = "github:hyprwm/Hyprland";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-update-script = {
      url = "github:Terrame0/nixos-update-script";
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
    nixos-cli = {
      url = "github:nix-community/nixos-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager";
      };
    };
    # -- do not override nixpkgs input (per their README.md)
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    # -- does not have a nixpkgs input
    sundry-input.url = "github:Terrame0/sundry";
  };

  outputs = inputs @ {
    self,
    sops-nix,
    nixpkgs,
    home-manager,
    sundry-input,
    hyprland,
    nixos-cli,
    ...
  }: let
    username = "terrame";
    hosts = [
      {
        name = "legion-y520";
        system-state-version = "26.05";
        system = "x86_64-linux";
        cores = 4;
      }
      {
        name = "desktop";
        system-state-version = "25.05";
        system = "x86_64-linux";
        cores = 8;
      }
      {
        name = "tuf-f17";
        system-state-version = "26.05";
        system = "x86_64-linux";
        cores = 16;
      }
    ];
  in {
    test = import ./infrastructure/design-system rec {
      pkgs = import nixpkgs {system = "x86_64-linux";};
      sundry = sundry-input.mk-lib {inherit pkgs;};
      lib = pkgs.lib;
    };
    nixosConfigurations = builtins.foldl' (acc: x: acc // x) {} (
      map (host: let
        pkgs = import nixpkgs {inherit (host) system;};
        sundry = sundry-input.mk-lib {inherit pkgs;};
        config-root = self.outPath;
        lib = pkgs.lib;
        module-args = {
          inherit inputs;
          inherit username;
          inherit host;
          inherit config-root;
          inherit sundry;
          inherit settings;
          inherit design-system;
        };
        design-system = import ./infrastructure/design-system {inherit sundry lib;};
        settings = lib.pipe ./infrastructure/settings [
          sundry.vfs.dir.from-src
          sundry.vfs.dir.load-nix
          (sundry.vfs.dir.collapse
            (path: file: {${sundry.vfs.path.get.stem path} = file.expr;}))
          sundry.attrs.merge.recursive.no-collision
        ];
        modules = lib.pipe config-root [
          sundry.vfs.dir.from-src
          (sundry.vfs.dir.filter
            (path: file: sundry.vfs.path.get.ext path == "nix"))
          sundry.vfs.dir.resolve-tags
          (sundry.vfs.dir.select-by-tag
            (_:
              with _;
                (tag {modules = [];})
                && !(tag {parts = [];} || tag {dotfiles = [];})
                && (tag {hosts = host.name;} || !tag {hosts = [];})))
        ];
        filter-modules = tag-value:
          lib.pipe modules [
            (sundry.vfs.dir.select-by-tag (_: with _; deepest-tag {modules = tag-value;}))
            (sundry.vfs.dir.collapse (path: file: file.origin))
          ];
        home-manager-config.home-manager = {
          extraSpecialArgs = module-args;
          useGlobalPkgs = true;
          useUserPackages = true;
          backupFileExtension = "hm-backup";
          users.${username}.imports =
            (filter-modules "user")
            ++ [
              inputs.zen-browser.homeModules.beta
            ];
        };
      in {
        ${host.name} = nixpkgs.lib.nixosSystem {
          specialArgs = module-args;
          inherit (host) system;
          modules =
            (filter-modules "system")
            ++ [
              nixos-cli.nixosModules.nixos-cli
              hyprland.nixosModules.default
              home-manager.nixosModules.home-manager
              sops-nix.nixosModules.sops
              home-manager-config
            ];
        };
      })
      hosts
    );
  };
}
