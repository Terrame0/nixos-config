{
  config,
  lib,
  sundry,
  ...
}: {
  services.searx = {
    enable = true;
    environmentFile = config.sops.secrets."searx/secret".path;
    redisCreateLocally = true;
    configureUwsgi = false;
    settings = {
      search.suspended_times = {
        SearxEngineTooManyRequests = 60;
        SearxEngineCaptcha = 600;
        cf_SearxEngineCaptcha = 86400;
        cf_SearxEngineAccessDenied = 21600;
      };
      outgoing = {
        request_timeout = 3.0;
        max_request_timeout = 15.0;
      };
      search = {
        favicon_resolver = "duckduckgo";
        autocomplete = "duckduckgo";
        autocomplete_min = 4;
        ban_time_on_fail = 10;
        max_ban_time_on_fail = 300;
      };
      server = {
        base_url = "http://localhost:8888";
        secret_key = "$SEARXNG_SECRET";
        limiter = false;
        image_proxy = true;
      };
      engines =
        map
        (list:
          sundry.list.zip-to-attrs
          ["disabled" "name" "engine" "weight" "base_url"]
          ([false] ++ list))
        [
          ["wikipedia" "wikipedia" 2.0]
          ["google_us" "google" 1.5 "https://www.google.com"]
          ["google_uk" "google" 1.5 "https://www.google.co.uk"]
          ["duckduckgo" "duckduckgo" 1.0]
          ["brave" "brave" 1.0]
          ["bing_com" "bing" 1.0 "https://www.bing.com"]
          ["bing_cn" "bing" 1.0 "https://cn.bing.com"]
          ["yahoo" "yahoo" 0.7]
          ["dogpile" "dogpile" 0.7]
        ];
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
