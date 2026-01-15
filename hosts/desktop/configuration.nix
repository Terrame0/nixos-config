{
  lib,
  pkgs,
  ...
}: {
  # -- importing modules and other stuff
  imports =
    [
      ../../modules/utils/nixos-update.nix
    ]
    ++ lib.filter
    (path: lib.hasSuffix ".nix" (toString path))
    (lib.filesystem.listFilesRecursive ../../modules/system);

  # -- allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # -- enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # -- system state version
  system.stateVersion = "25.11";

  # -- boot configuration
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  # -- networking
  networking.networkmanager.enable = true;
  networking.hostName = "laptop";

  # -- time and locale
  time.timeZone = "Asia/Vladivostok";

  # -- user configuration
  programs.zsh.enable = true;
  users.users.terrame = {
    isNormalUser = true;
    description = "Terrame";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
    packages = [];
  };
}
