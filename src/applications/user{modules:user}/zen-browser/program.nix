args @ {pkgs, ...}: let
  config-dir = ./${"config{parts}"};
in {
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    nativeMessagingHosts = with pkgs; [ff2mpv-rust];
    profiles = {
      default = {
        name = "default";
        isDefault = true;
        search = import (config-dir + "/search.nix") args;
      };
    };
    policies = import (config-dir + "/policies.nix") args;
  };
}
