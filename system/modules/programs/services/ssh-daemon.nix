{config, ...}: {
  sops.templates."authorized-keys" = {
    content = "${config.sops.placeholder."authorized-ssh-keys/authorized-keys"}";
    owner = "terrame";
    group = "users";
    mode = "0600";
  };
  services.openssh = {
    enable = true;

    authorizedKeysFiles = [
      config.sops.templates."authorized-keys".path
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
