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
    nuenv = {
      url = "github:philocalyst/nuenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    microsoft-fonts.url = "github:kugland/nix-ttf-ms-win11-auto";
    # -- do not override nixpkgs input (per their README.md)
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    # -- does not have a nixpkgs input
    sundry-input.url = "github:Terrame0/sundry";
    idef0-svg-gost = {
      url = "github:Terrame0/IDEF0-SVG-GOST-wrapped";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.sundry-input.follows = "sundry-input";
    };
  };
  outputs = inputs:
    (import ./meta/system-assembly/each-host.nix inputs)
    (args @ {
      host,
      inputs,
      ...
    }: {
      nixosConfigurations.${host.name} =
        inputs.nixpkgs.lib.nixosSystem
        ({inherit (host) system;} // (import ./meta/system-assembly/module-glob.nix args));
    });
}
