{lib, ...}: {
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      show-input-source-switcher = false;
      color-scheme = "prefer-dark";
      gtk-theme = "Adwaita";
      icon-theme = "Adwaita";
      font-name = "JetBrainsMono Nerd Font 12";
      document-font-name = "JetBrainsMono Nerd Font 12";
      monospace-font-name = "JetBrainsMono Nerd Font 12";
      accent-color = "blue";
      show-battery-percentage = true;
      enable-hot-corners = false;
      locate-pointer = false;
      toolkit-accessibility = false;
    };
  };
}
