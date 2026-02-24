{ pkgs, ... }:
let
  unstable =
    import
      (fetchTarball {
        url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
        sha256 = "04lns5xspj7nd99ygwf8js5syabbrc9zbgsnalgibc2n9r4vrhcs";
      })
      {
        system = pkgs.stdenv.hostPlatform.system;
        config = { };
      };
  overlay = self: super: {
    hyprland = unstable.hyprland;
  };
in
{
  nixpkgs.overlays = [ overlay ];
}
