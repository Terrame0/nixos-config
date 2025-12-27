{
  description = "nixos-update script with decoupled dependencies and a system-wide package";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    nixos-update-script = pkgs.writeShellScriptBin "nixos-update" (builtins.readFile ./wrapper.sh);
  in {
    # -- a shell to run the update script in
    devShells.${system}.nixos-update = pkgs.mkShell {
      buildInputs = with pkgs; [
        git
        bash
        alejandra
      ];
    };

    # -- expose the update script derivation as a module
    nixosModules.nixos-update = {...}: {
      environment.systemPackages = [nixos-update-script];
    };
  };
}
