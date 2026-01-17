{...}: let
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
  programs.firefox = {
    enable = true;
    policies = {
      # -- app-level policies
      DisableTelemetry = true;
      DisableFirefoxStudies = true;
      DisablePocket = true;
      DisableAppUpdate = true;
      DontCheckDefaultBrowser = true;
      DisableFeedbackCommands = true;
      SearchBar = "unified";

      Preferences = {
        # -- dns over https
        "network.trr.mode" = {
          Value = 2;
          Status = "locked";
        };
        "network.trr.uri" = {
          Value = "https://dns.adguard.com/dns-query";
          Status = "locked";
        };

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
