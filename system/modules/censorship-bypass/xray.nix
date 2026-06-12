{config, ...}: {
  sops.templates."xray-config".content =
    builtins.toJSON {
    };

  # services.xray = {
  #   enable = true;
  #   settingsFile = config.sops.templates."xray-config".path;
  # };
}
