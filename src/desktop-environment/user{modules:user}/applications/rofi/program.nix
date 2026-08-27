{...}: {
  programs.rofi = {
    enable = true;
    # -- the hm-generated config collides with the dotfile one
    # - and we want the native syntax over the hm nix attrs -> rasi one
    configPath = ".config/rofi/dummy-config.rasi";
  };
}
