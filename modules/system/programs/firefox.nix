{...}: let
  lock-false = {
    Value = false;
    Status = "locked";
  };
  lock-true = {
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
      SearchBar = "unified";

      Preferences = {
        # -- telemetry / reporting
        "toolkit.telemetry.unified" = lock-false;
        "toolkit.telemetry.enabled" = lock-false;
        "datareporting.policy.dataSubmissionEnabled" = lock-false;
        "datareporting.healthreport.uploadEnabled" = lock-false;

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
