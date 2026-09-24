args @ {
  inputs,
  pkgs,
  sundry,
  root-vfs,
  ...
}: let
  config-subtree = sundry.vfs.dir.get ./config root-vfs;
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
