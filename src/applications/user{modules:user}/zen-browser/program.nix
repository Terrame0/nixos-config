args @ {
  inputs,
  pkgs,
  root-vfs,
  ...
}: let
  config-subtree = root-vfs.src.applications.user.zen-browser.config;
in {
  imports = [inputs.zen-browser.homeModules.beta];
  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;
    nativeMessagingHosts = with pkgs; [ff2mpv-rust];
    profiles = {
      default = {
        name = "default";
        isDefault = true;
        search = config-subtree."search.nix".expr args;
      };
    };
    policies = config-subtree."policies.nix".expr args;
  };
}
