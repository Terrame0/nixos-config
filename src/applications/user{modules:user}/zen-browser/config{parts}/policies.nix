args @ {...}: let
  lock = value: {
    Value = value;
    Status = "locked";
  };
  args' = args // {inherit lock;};
in {
  # -- app-level policies
  DisableTelemetry = true;
  DisableFirefoxStudies = true;
  DisableAppUpdate = true;
  DontCheckDefaultBrowser = true;
  DisableFeedbackCommands = true;
  DisableSetDesktopBackground = true;
  GoToIntranetSiteForSingleWordEntryInAddressBar = false;
  NetworkPrediction = true;
  OverrideFirstRunPage = "";
  OverridePostUpdatePage = "";
  SearchBar = "unified";
  SkipTermsOfUse = true;

  Homepage = {
    URL = "about:newtab";
    Locked = true;
    StartPage = "previous-session";
    NewTabOnRestore = false;
  };

  FirefoxHome = {
    Search = false;
    Weather = false;
    TopSites = false;
    SponsoredTopSites = false;
    Highlights = false;
    Pocket = false;
    Stories = false;
    SponsoredPocket = false;
    SponsoredStories = false;
    Snippets = false;
    Locked = true;
  };

  FirefoxSuggest = {
    WebSuggestions = false;
    SponsoredSuggestions = false;
    ImproveSuggest = false;
    OnlineEnabled = false;
    Locked = true;
  };

  AIControls = {
    Default = {
      Value = "blocked";
      Locked = true;
    };
    Translations = {
      Value = "available";
      Locked = true;
    };
  };

  EnableTrackingProtection = {
    Value = true;
    Category = "standard";
    Locked = true;
  };

  # InstallAddonsPermission = {
  #   Default = false;
  # };

  Preferences = import ./preferences.nix args';

  ExtensionSettings = import ./extensions.nix args';
}
