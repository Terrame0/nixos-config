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
    microsoft-fonts.url = "github:kugland/nix-ttf-ms-win11-auto";

    # -- do not override nixpkgs input (per their README.md)
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    # -- does not have a nixpkgs input
    sundry-input.url = "github:Terrame0/sundry";
  };
  outputs = inputs @ {
    self,
    nixpkgs,
    sundry-input,
    ...
  }: let
    username = "terrame";
    hosts = import ./meta/hosts.nix;
  in {
    nixosConfigurations = builtins.foldl' (acc: x: acc // x) {} (
      map (host: let
        config-root = self.outPath;
        pkgs = import nixpkgs {inherit (host) system;};
        sundry = sundry-input.mk-lib {inherit pkgs;};
        lib = pkgs.lib;
        design-system = import ./meta/design-system meta-args;
        settings = lib.pipe ./meta/settings [
          sundry.vfs.dir.from-src
          sundry.vfs.dir.load-nix
          (sundry.vfs.dir.collapse
            (path: file: {${sundry.vfs.path.get.stem path} = file.expr;}))
          sundry.attrs.merge.recursive.no-collision
        ];
        module-args = {
          inherit
            design-system
            config-root
            settings
            username
            host
            sundry
            inputs
            ;
        };
        meta-args = {
          inherit
            module-args
            config-root
            username
            host
            sundry
            pkgs
            lib
            ;
        };
      in {
        ${host.name} =
          nixpkgs.lib.nixosSystem
          ({inherit (host) system;} // (import ./meta/module-globbing meta-args));
      })
      hosts
    );
  };
}
