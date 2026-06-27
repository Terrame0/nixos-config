{
  services.asusd = {
    enable = true;
    asusdConfig.source = ./config.ron;
    fanCurvesConfig.source = ./fan-curves.ron;
    auraConfigs.tuf.source = ./aura-tuf.ron;
  };
}
