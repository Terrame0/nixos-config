{inputs, ...}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [inputs.nix4vscode.overlays.default];
  nix.settings = {
    "experimental-features" = [
      "nix-command"
      "flakes"
    ];
  };
}
