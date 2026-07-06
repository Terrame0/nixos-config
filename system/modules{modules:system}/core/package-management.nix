{inputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [inputs.nix4vscode.overlays.default];
  };
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://cache.nixos.org"
      ];
    };
  };
}
