{config, ...}: {
  services.openssh = {
    enable = true;
    authorizedKeysFiles = [
      config.sops.secrets."authorized-ssh-keys/authorized-keys".path
    ];
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      ChallengeResponseAuthentication = false;
      UsePAM = false;
      PubkeyAuthentication = true;
      MaxAuthTries = 3;
      LogLevel = "VERBOSE";
    };
  };
}
