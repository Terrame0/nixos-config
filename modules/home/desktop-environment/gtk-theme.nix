{pkgs, ...}: {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    theme.name = "my-theme";
    iconTheme = {
      # name = "Papirus-Dark";
      # package = pkgs.papirus-icon-theme.override {
      #   color = "brown";
      # };
      name = "Adwaita";
      package = pkgs.gnome-themes-extra;
    };
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };
}
