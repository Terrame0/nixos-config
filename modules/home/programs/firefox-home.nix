{...}: {
  programs.firefox = {
    enable = true;

    profiles = {
      default = {
        name = "default";
        isDefault = true;

        settings = let
          pac-file = builtins.path {
            path = ../program-configurations/firefox-pac.js;
          };
        in {
          # -- proxy (pac via xray)
          "network.proxy.type" = 2; # -- auto-config (PAC)
          "network.proxy.autoconfig_url" = "file://${pac-file}";

          # -- startup behaviour
          "browser.startup.homepage" = "about:blank";
          "browser.startup.page" = 3; # -- auto restore session

          # -- session restore
          "browser.sessionstore.resume_from_crash" = true;
          "browser.sessionstore.resume_session_once" = false;

          # -- new tab behaviour
          "browser.urlbar.focusOnNewTab" = true; # -- autofocus on search bar
          "browser.toolbars.bookmarks.visibility" = "never"; # -- hide bookmarks bar

          # -- show only engines defined in config
          "browser.search.separatePrivateDefault.ui.enabled" = false;
          "browser.search.showOneOffButtons" = false;

          # -- password and forms
          "signon.rememberSignons" = true;
          "browser.formfill.enable" = true;

          # -- ui
          "browser.aboutConfig.showWarning" = false;
          "browser.uidensity" = 1; # -- 1 is default, 0 is compact

          # -- tab behaviour
          "browser.tabs.warnOnClose" = false;
          "browser.tabs.closeWindowWithLastTab" = true;

          # -- performance
          "browser.cache.disk.enable" = true;
          "browser.sessionstore.interval" = 15000;

          # -- launch on the current workspace
          "widget.disable-workspace-management" = true;
        };

        search = {
          force = true;
          default = "ddg";
          order = [
            "ddg"
            "google"
            "yandex"
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

            "Nix Flakes" = {
              urls = [
                {
                  template = "https://search.nixos.org/flakes";
                  params = [
                    {
                      name = "q";
                      value = "{searchTerms} flake.nix";
                    }
                  ];
                }
              ];
              icon = "https://nixos.org/favicon.ico";
              definedAliases = ["@nf"];
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
          };
        };
      };
    };
  };
}
