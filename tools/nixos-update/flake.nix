{
  description = "python nixos update script";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  outputs = {nixpkgs, ...}: let
    system = "x86_64-linux";
    pkgs = import nixpkgs {inherit system;};
    # -- building package with setuptools (details in pyproject.toml)
    nixos-update-script = pkgs.python3Packages.buildPythonApplication {
      pname = "nixos-update";
      version = "0.1.0";
      src = ./.;
      pyproject = true;
      build-system = [pkgs.python3Packages.setuptools];
      propagatedBuildInputs = with pkgs; [
        git
        nix-output-monitor
        meld
        alejandra
      ];
    };
  in {
    packages.${system}.default = nixos-update-script;
    devShells.${system}.default = pkgs.mkShell {
      buildInputs = [nixos-update-script];
    };
  };
}
