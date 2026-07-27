{...}: {
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;

      history = {
        max_size = 10000;
        sync_on_enter = true;
        file_format = "sqlite";
        isolation = false;
      };

      completions = {
        quick = true;
        partial = true;
        algorithm = "fuzzy";
        external = {
          enable = true;
          max_results = 100;
        };
      };

      table = {
        mode = "compact";
      };
    };
  };
}
