{...}: {
  services.ssh-agent = {
    enable = true;
    defaultMaximumIdentityLifetime = 3600;
  };
}
