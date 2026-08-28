{...}: {
  enable = true;

  settings = {
    show_banner = false;

    history = {
      max_size = 10000;
      sync_on_enter = true;
      file_format = "sqlite";
      isolation = false;
    };

    table.mode = "compact";
  };
}
