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
      DisableAppUpdate = true;
      DisableFeedbackCommands = true;
      DisableProfileRefresh = true;
      DisableCrashReporter = true;

      SearchBar = "unified";

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

        # -- safe browsing
        "browser.safebrowsing.malware.enabled" = lock-true;
        "browser.safebrowsing.phishing.enabled" = lock-true;

        # -- cookies (allow normal behaviour)
        "network.cookie.cookieBehavior" = {
          Value = 0;
          Status = "locked";
        };

        # -- tracking protection
        "privacy.trackingprotection.enabled" = lock-true;
        "privacy.trackingprotection.socialtracking.enabled" = lock-true;
        "privacy.donottrackheader.enabled" = lock-true;

        # -- new tab / sponsored
        "extensions.pocket.enabled" = lock-false;
        "browser.newtabpage.pinned" = lock-empty-string;
        "browser.topsites.contile.enabled" = lock-false;
        "browser.newtabpage.activity-stream.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.system.showSponsored" = lock-false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = lock-false;

        # -- ui behaviour
        "browser.startup.homepage" = {
          Value = "about:blank";
          Status = "locked";
        };
        "browser.startup.page" = {
          Value = 1;
          Status = "locked";
        };

        # -- hide bookmarks bar globally
        "browser.toolbars.bookmarks.visibility" = {
          Value = "never";
          Status = "locked";
        };
      };

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
          installation_mode = "force_installed";
        };

        "ReturnYouTubeDislike@pollo.xyz" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/return-youtube-dislike/latest.xpi";
          installation_mode = "force_installed";
        };

        "video_downloadhelper@yahoo.com" = {
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/video-downloadhelper/latest.xpi";
          installation_mode = "force_installed";
        };

        "*" = {
          installation_mode = "blocked";
        };
      };
    };
  };
}
