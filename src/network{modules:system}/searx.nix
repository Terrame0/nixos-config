{
  config,
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
        pool_connections = 20;
        request_timeout = 10.0;
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
          ["startpage" "startpage" 1.2]
          ["duckduckgo" "duckduckgo" 1.0]
          ["brave" "brave" 1.0]
          ["bing_com" "bing" 1.0 "https://www.bing.com"]
          ["bing_cn" "bing" 1.0 "https://cn.bing.com"]
          ["qwant" "qwant" 1.0]
          ["mojeek" "mojeek" 1.0]
          ["yep" "yep" 0.8]
          ["yahoo" "yahoo" 0.7]
          ["dogpile" "dogpile" 0.7]
          ["swisscows" "swisscows" 0.6]

          ["github" "github" 1.2]
          ["stackoverflow" "stackoverflow" 1.0]

          ["openverse" "openverse" 1.0]
          ["unsplash" "unsplash" 1.0]
          ["flickr" "flickr_noapi" 0.8]

          ["peertube" "peertube" 1.0 "https://tube.4aem.com"]
          ["rumble" "rumble" 0.8]
          ["dailymotion" "dailymotion" 0.7]
          ["vimeo" "vimeo" 0.7]

          ["wikidata" "wikidata" 1.5]
          ["arxiv" "arxiv" 1.0]
          ["semantic_scholar" "semantic_scholar" 0.8]
          ["pubmed" "pubmed" 0.8]
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
