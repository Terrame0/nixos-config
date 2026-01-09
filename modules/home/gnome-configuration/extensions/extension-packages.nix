{pkgs, ...}: let
  # -- gnome extension list
  extension-list = with pkgs.gnomeExtensions; [
    vitals
    clipboard-indicator
  ];

  # -- lambda expression that gets the uuid of a derivation
  get-extension-uuid = extension:
    builtins.attrNames (
      builtins.readDir "${extension}/share/gnome-shell/extensions"
    );

  # -- creates a list using the lambda expression defined above
  uuids =
    builtins.concatLists (map get-extension-uuid extension-list);
in {
  home.packages = extension-list; # -- installs extensions as packages
  # -- enables them in dconf
  dconf.settings."org/gnome/shell" = {
    enabled-extensions = uuids;
    disabled-extensions = [];
  };
}
