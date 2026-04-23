{pkgs, ...}: let
  unstable =
    import
    (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/nixos-unstable.tar.gz";
      sha256 = "00a3mfk96r00j26mnblm6rlimrfl35sjrq4zy94mpc5c2jqmx3i3";
    })
    {
      system = pkgs.stdenv.hostPlatform.system;
      config = {};
    };
  overlay = self: super: {
    hyprland = unstable.hyprland;
  };
in {
  nixpkgs.overlays = [overlay];
}
