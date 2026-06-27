{
  services.asusd = {
    enable = true;
    asusdConfig.source = ./asusd.ron;
    auraConfigs.tuf.source = ./aura.ron;
  };
}
