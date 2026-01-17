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

          # -- startup behaviour
          "browser.startup.homepage" = "about:blank";
          "browser.startup.page" = 3; # -- auto restore session

          # -- session restore
          "browser.sessionstore.resume_from_crash" = true;
          "browser.sessionstore.resume_session_once" = false;

          # -- search defaults
          "browser.search.defaultenginename" = "ddg";
          "browser.search.order.1" = "ddg";
        };
        search = {
          force = true;
          default = "ddg";
          order = [
            "ddg"
            "google"
            "NixOS Packages"
            "NixOS Options"
            "Nix Flakes"
            "Home Manager Options"
          ];

          engines = {
            "NixOS Packages" = {
              urls = [
                {
                  template = "https://search.nixos.org/packages";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://nixos.org/favicon.ico";
              definedAliases = ["@np"];
            };

            "NixOS Options" = {
              urls = [
                {
                  template = "https://search.nixos.org/options";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://nixos.org/favicon.ico";
              definedAliases = ["@no"];
            };

            "Home Manager Options" = {
              urls = [
                {
                  template = "https://home-manager-options.extranix.com/";
                  params = [
                    {
                      name = "query";
                      value = "{searchTerms}";
                    }
                  ];
                }
              ];
              icon = "https://nixos.org/favicon.ico";
              definedAliases = ["@hm"];
            };

            "Nix Flakes" = {
              urls = [
                {
                  template = "https://github.com/search";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms} flake.nix";
                    }
                  ];
                }
              ];
              icon = "https://github.com/favicon.ico";
              definedAliases = ["@nf"];
            };
          };
        };
      };
    };
  };
}
