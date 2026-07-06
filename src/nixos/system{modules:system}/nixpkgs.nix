{inputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [inputs.nix4vscode.overlays.default];
  };
}
