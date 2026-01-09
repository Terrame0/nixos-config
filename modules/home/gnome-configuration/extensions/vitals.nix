{...}: {
  dconf.settings = {
    "org/gnome/shell/extensions/vitals" = {
      alphabetize = false;
      fixed-widths = false;
      hide-icons = true;
      hot-sensors = [
        "__network-rx_max__"
        "_memory_free_"
        "__temperature_avg__"
      ];
      icon-style = 1;
      position-in-panel = 2;
    };
  };
}
