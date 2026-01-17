{
  description = "python nixos update script";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
  outputs = {nixpkgs, ...}: let
    target-system = "x86_64-linux"; # -- system we are building for
    pkgs = nixpkgs.legacyPackages.${target-system};
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
    packages.${target-system}.default = nixos-update-script;
    devShells.${target-system}.default = pkgs.mkShell {
      buildInputs = [nixos-update-script];
    };
  };
}
