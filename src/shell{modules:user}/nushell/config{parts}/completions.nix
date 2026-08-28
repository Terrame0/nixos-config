{...}: {
  settings.completions = {
    quick = true;
    partial = true;
    algorithm = "fuzzy";
    external = {
      enable = true;
      max_results = 100;
    };
  };
}
