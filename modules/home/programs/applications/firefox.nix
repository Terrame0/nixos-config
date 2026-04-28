{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    package = pkgs.firefox;

    nativeMessagingHosts = with pkgs; [
      ff2mpv-rust
    ];

    profiles = {
      default = {
        name = "default";
        isDefault = true;

        settings = {
          # -- dns over https
          "network.trr.mode" = 2;
          "network.trr.uri" = "https://dns.cloudflare.com/dns-query";

          # -- routing through pacproxy
          "network.proxy.type" = 0;
          # "network.proxy.http" = "127.0.0.1";
          # "network.proxy.http_port" = 8080;
          # "network.proxy.ssl" = "127.0.0.1";
          # "network.proxy.ssl_port" = 8080;

          # -- all traffix goes through pacproxy
          "network.proxy.no_proxies_on" = "";

          # -- startup behaviour
          "browser.startup.homepage" = "about:newtab";
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
          default = "google";
          order = [
            "google"
            "ddg"
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

    policies = let
      lock-false = {
        Value = false;
        Status = "locked";
      };
      lock-true = {
        Value = true;
        Status = "locked";
      };
      lock-default = {
        Value = true;
        Status = "locked";
      };
    in {
      # -- app-level policies
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableAppUpdate = true;
      DontCheckDefaultBrowser = true;
      DisableFeedbackCommands = true;
      SearchBar = "unified";

      Preferences = {
        # -- telemetry / reporting
        "toolkit.telemetry.unified" = lock-false;
        "toolkit.telemetry.enabled" = lock-false;
        "datareporting.policy.dataSubmissionEnabled" = lock-default; # -- BREAKS GOOGLE AUTO AUTH
        "datareporting.healthreport.uploadEnabled" = lock-false;

        # -- safe browsing
        "browser.safebrowsing.malware.enabled" = lock-true;
        "browser.safebrowsing.phishing.enabled" = lock-true;

        # -- new tab / sponsored
        "extensions.pocket.enabled" = lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;
      };

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "ff2mpv@yossarian.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ff2mpv/latest.xpi";
          installation_mode = "force_installed";
        };
        "*" = {
          installation_mode = "blocked";
        };
      };
    };
  };
}
