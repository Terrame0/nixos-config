{
  config,
  pkgs,
  ...
}: let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
    Value = true;
    Status = "locked";
  };
  lock-empty-string = {
    Value = "";
    Status = "locked";
  };
in {
  programs.firefox = {
    enable = true;

    policies = {
      # -- app-level policies
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DontCheckDefaultBrowser = true;

      # -- keep nix in control of updates
      DisableAppUpdate = true;

      # -- extra data collection controls
      DisableFeedbackCommands = true;
      DisableProfileRefresh = true;
      DisableCrashReporter = true;

      SearchBar = "unified";

      # -- preferences (privacy hardening)
      Preferences = {
        # -- telemetry / reporting
        "toolkit.telemetry.unified" = lock-false;
        "toolkit.telemetry.enabled" = lock-false;
        "toolkit.telemetry.server" = {
          Value = "";
          Status = "locked";
        };
        "datareporting.policy.dataSubmissionEnabled" = lock-false;
        "datareporting.healthreport.uploadEnabled" = lock-false;
        "breakpad.reportURL" = {
          Value = "";
          Status = "locked";
        };

        # -- safe browsing (local lists)
        "browser.safebrowsing.malware.enabled" = lock-true;
        "browser.safebrowsing.phishing.enabled" = lock-true;

        # -- cookies / tracking
        "network.cookie.cookieBehavior" = {
          Value = 1;
          Status = "locked";
        };

        "privacy.trackingprotection.enabled" = lock-true;
        "privacy.trackingprotection.socialtracking.enabled" = lock-true;
        "privacy.donottrackheader.enabled" = lock-true;

        # -- new tab / pocket / sponsored
        "extensions.pocket.enabled" = lock-false;
        "browser.newtabpage.pinned" = lock-empty-string;
        "browser.topsites.contile.enabled" = lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;

        # -- ui behaviour (system defaults)
        "browser.startup.homepage" = {
          Value = "about:blank";
          Status = "locked";
        };
        "browser.startup.page" = {
          Value = 1; # -- homepage
          Status = "locked";
        };

        "dom.disable_open_during_load" = lock-true;
      };

      # -- extensions
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };
        "jid1-MnnxcxisBPnSXQ@jetpack" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/privacy-badger17/latest.xpi";
          installation_mode = "force_installed";
        };
        "extension@tabliss.io" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/file/3940751/tabliss-2.6.0.xpi";
          installation_mode = "force_installed";
        };

        "*" = {
          installation_mode = "blocked";
        };
      };

      # -- managed bookmarks
      ManagedBookmarks = [
        {
          title = "Managed Bookmarks";
          children = [
            {
              title = "YouTube";
              url = "https://www.youtube.com";
            }
            {
              title = "YouTube Music";
              url = "https://music.youtube.com";
            }
            {
              title = "ChatGPT";
              url = "https://chat.openai.com";
            }
            {
              title = "DeepSeek";
              url = "https://www.deepseek.com";
            }
            {
              title = "GitHub";
              url = "https://github.com";
            }
            {
              title = "VK";
              url = "https://vk.com";
            }
          ];
        }
      ];
    };
  };
}
