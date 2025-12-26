{...}:
{
  imports = [
    ../../modules/applications.nix
    ../../modules/desktop.nix
    ../../modules/gc.nix
    ../../modules/graphics.nix
    ../../modules/nix-ld.nix
    ../../modules/sound.nix
    ../../scripts/nixos-update/wrapper.nix
  ];

  # -- enable flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # -- system state version
  system.stateVersion = "25.05";

  # -- boot configuration
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  }; 

  # -- networking
  networking.hostName = "laptop";
  networking.networkmanager.enable = true;

  # -- time and locale
  time.timeZone = "Asia/Vladivostok";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };

  # -- user configuration
  users.users.terrame = {
    isNormalUser = true;
    description = "Terrame";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [];
  };

  # -- touchpad support
  services.libinput.enable = true;
}