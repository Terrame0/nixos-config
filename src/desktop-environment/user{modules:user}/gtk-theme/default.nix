{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-themes-extra
  ];

  # -- gtk apps use this dconf setting
  # - to determine the default theme
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  gtk = {
    enable = true;
    gtk4.theme = null;
    theme.name = "Adwaita-dark";
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {
        color = "brown";
      };
    };
  };

  home.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };
}
