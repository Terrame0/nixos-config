{inputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.nix4vscode.overlays.default
      inputs.nix-cachyos-kernel.overlays.pinned
      inputs.nuenv.overlays.default
    ];
  };
}
