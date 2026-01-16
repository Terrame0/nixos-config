{...}: {
  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        id = 0;
        name = "default";
        isDefault = true;

        # -- user preferences
        settings = {
          # -- proxy (manual socks v5)
          "network.proxy.type" = 1; # -- manual
          "network.proxy.socks" = "127.0.0.1";
          "network.proxy.socks_port" = 10808;
          "network.proxy.socks_version" = 5;

          # -- route dns through socks
          "network.proxy.socks_remote_dns" = true;

          # -- no proxy list
          "network.proxy.no_proxies_on" = ".deepseek.com, .youtube.com, .vk.com, .yandex.ru, .duckduckgo.com, .google.com";

          # -- startup behaviour
          "browser.startup.homepage" = "about:blank";
          "browser.startup.page" = 3;

          # -- make session store more reliable
          "browser.sessionstore.resume_from_crash" = true;
          "browser.sessionstore.resume_session_once" = false;

          # -- keep tabs in memory for faster restore
          "browser.sessionstore.restore_pinned_tabs_on_demand" = false;

          # -- search defaults (ui consistency)
          "browser.search.defaultenginename" = "DuckDuckGo";
          "browser.search.order.1" = "DuckDuckGo";

          # -- password and forms (enabled as requested)
          "signon.rememberSignons" = true;
          "browser.formfill.enable" = true;

          # -- ui
          "widget.use-xdg-desktop-portal.file-picker" = 1;
          "browser.aboutConfig.showWarning" = false;
          "browser.compactmode.show" = true;
          "browser.uidensity" = 1; # 0=normal, 1=compact

          # -- tab behaviour
          "browser.tabs.warnOnClose" = true;
          "browser.tabs.closeWindowWithLastTab" = false;

          # -- being kind to the ssd
          "browser.cache.disk.enable" = false;
          "browser.sessionstore.interval" = 15000;

          # -- launch on the current workspace
          "widget.disable-workspace-management" = true;

          # -- popups
          "dom.disable_open_during_load" = true;
        };

        # -- search configuration
        search = {
          force = true;
          default = "DuckDuckGo";
          order = [
            "DuckDuckGo"
            "Google"
            "NixOS Packages"
            "NixOS Options"
            "Nix Flakes"
            "Home Manager Options"
          ];

          engines = {
            # -- nixos package search
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

            # -- nixos package option search
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

            # -- home manager option search
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

            # -- nix flake search
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
