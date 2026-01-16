{...}: {
  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;

        settings = {
          # -- proxy (manual http/https)
          "network.proxy.type" = 1; # -- manual
          "network.proxy.http" = "127.0.0.1";
          "network.proxy.http_port" = 10808;
          "network.proxy.ssl" = "127.0.0.1";
          "network.proxy.ssl_port" = 10808;
          "network.proxy.no_proxies_on" = ".deepseek.com,.youtube.com,.vk.com,.yandex.ru,.duckduckgo.com,.google.com";
        };
      };
    };
  };
}
