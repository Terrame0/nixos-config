{
  services.asusd = {
    enable = true;
    asusdConfig.source = ./asusd.ron;
    fanCurvesConfig.source = ./fan_curves.ron;
    auraConfigs.aura-tuf.source = ./aura_tuf.ron;
  };
}
