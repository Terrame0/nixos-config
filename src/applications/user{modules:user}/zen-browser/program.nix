args @ {
  inputs,
  pkgs,
  sundry,
  root,
  flake-file-tree,
  ...
}: let
  config-file-tree = sundry.vfs.dir.get-relative-to root ./config flake-file-tree;
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
        search = config-file-tree."search.nix".expr args;
      };
    };
    policies = config-file-tree."policies.nix".expr args;
  };
}
