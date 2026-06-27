{
  services.asusd = {
    enable = true;
    asusdConfig.source = ./config.ron;
    fanCurvesConfig.source = ./fan-curves.ron;
    auraConfigs.aura-tuf.source = ./aura-tuf.ron;
  };
}
