{inputs, ...}: {
  nixpkgs = {
    config.allowUnfree = true;
    config.problems.handlers.nu_plugin_units.broken = "warn";
    overlays = [
      inputs.nix4vscode.overlays.default
      inputs.nix-cachyos-kernel.overlays.pinned
      inputs.nuenv.overlays.default
    ];
  };
}
