{nix4vscode, ...}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [nix4vscode.overlays.default];
  nix.settings = {
    "experimental-features" = [
      "nix-command"
      "flakes"
    ];
  };
}
