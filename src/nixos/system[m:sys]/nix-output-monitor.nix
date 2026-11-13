{pkgs-unstable, ...}: {
  nixpkgs.overlays = [
    # -- stable nom rejects structured activity types of determinate nix
    (final: prev: {nix-output-monitor = pkgs-unstable.nix-output-monitor;})
  ];
}
