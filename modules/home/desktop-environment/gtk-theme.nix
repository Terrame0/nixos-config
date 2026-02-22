{pkgs, ...}: {
  home.packages = with pkgs; [
    papirus-icon-theme
    gnome-themes-extra
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  xdg.configFile."gtk-3.0/settings.ini".text = ''
    [Settings]
    gtk-theme-name=Adwaita
    gtk-icon-theme-name=Adwaita
    gtk-application-prefer-dark-theme=true
  '';

  home.sessionVariables = {
    XCURSOR_THEME = "Adwaita";
    XCURSOR_SIZE = "24";
  };

  # gtk = {
  #   enable = true;
  #   theme.name = "Adwaita-dark";
  #   iconTheme.name = "Adwaita";
  #   cursorTheme = {
  #     name = "Papirus";
  #     package = pkgs.papirus-icon-theme;
  #     size = 24;
  #   };
  # };

  # xdg.configFile."gtk-4.0/settings.ini".text = ''
  #   [Settings]
  #   gtk-theme-name=Adwaita-dark
  #   gtk-icon-theme-name=Adwaita
  #   gtk-cursor-theme-name=Adwaita
  #   gtk-cursor-theme-size=24
  #   gtk-application-prefer-dark-theme=true
  # '';
}
