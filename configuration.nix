{...}:
{
  imports = [
    ./modules/applications.nix
    ./modules/desktop.nix
    ./modules/graphics.nix
    ./modules/patches.nix
    ./modules/nix-ld.nix
  ];
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # -- boot configuration
  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  }; 

  # -- autoremove old generations
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
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



  # -- sound
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # -- touchpad support
  services.libinput.enable = true;

  # -- user configuration
  users.users.terrame = {
    isNormalUser = true;
    description = "Terrame";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [];
  };

  # -- allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # -- system state version
  system.stateVersion = "25.05";
}