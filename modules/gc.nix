{...}:
{  

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

  # -- user configuration
  users.users.terrame = {
    isNormalUser = true;
    description = "Terrame";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = [];
  };
}