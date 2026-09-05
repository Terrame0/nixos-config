{
  config,
  lib,
  ...
}: {
  services.searx = {
    enable = true;
    environmentFile = config.sops.secrets."searx/secret".path;
    redisCreateLocally = true;
    runInUwsgi = false;
    settings = {
      server = {
        base_url = "http://localhost:8888";
        secret_key = "$SEARXNG_SECRET";
        limiter = false;
        image_proxy = true;
      };
      engines = lib.mapAttrsToList (name: value: {inherit name;} // value) {
        "yandex".disabled = false;
        "bing".disabled = false;
        "duckduckgo".disabled = false;
        "google".disabled = false;
        "wikidata".disabled = false;
        "openverse".disabled = false;
        "unsplash".disabled = false;
        "youtube".disabled = false;
        "peertube".disabled = false;
      };
      enabled_plugins = [
        "Infinite scroll"
        "Timezones plugin"
        "Self Information"
        "Unit converter plugin"
        "Tracker URL remover"
        "Open Access DOI rewrite"
        "Hash plugin"
      ];
    };
  };
}
