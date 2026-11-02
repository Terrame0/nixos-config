{inputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
    overlays = [
      inputs.nuenv.overlays.default
    ];
  };
}
