{
  description = "my nixos config flake";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    sundry-flake.url = "github:Terrame0/sundry";
    nuenv = {
      url = "github:philocalyst/nuenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-cli = {
      url = "github:nix-community/nixos-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    clanker-skill-index = {
      url = "github:Terrame0/clanker-skill-index";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-cachyos-kernel = {
      # -- do not override nixpkgs input (per their README.md)
      url = "github:xddxdd/nix-cachyos-kernel/release";
    };
    hyprland = {
      # -- do not override nixpkgs input
      # - this breaks version compatibility between hyprland components
      url = "github:hyprwm/Hyprland";
    };
    nix4vscode = {
      url = "github:nix-community/nix4vscode";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs-unstable";
        home-manager.follows = "home-manager";
      };
    };
    microsoft-fonts = {
      url = "github:kugland/nix-ttf-ms-win11-auto";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };
  outputs = inputs: let
    glob-modules = import ./meta/system-assembly/glob-modules.nix;
    each-host = import ./meta/system-assembly/each-host.nix;
    root = ./.;
  in
    each-host {inherit root inputs;}
    (args @ {
      host,
      inputs,
      design-tokens,
      sundry,
      ...
    }: {
      tokens.${host.name} = sundry.str.pretty design-tokens;
      nixosConfigurations.${host.name} =
        inputs.nixpkgs.lib.nixosSystem
        ({inherit (host) system;} // (glob-modules args));
    });
}
