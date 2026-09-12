{...}: {
  show_banner = false;
  history = {
    max_size = 10000;
    sync_on_enter = true;
    file_format = "sqlite";
    isolation = false;
  };
  use_ansi_coloring = true;
  use_kitty_protocol = true;
  highlight_resolved_externals = true;
  auto_cd_implicit = true;
  table = {
    show_empty = false;
    missing_value_symbol = "";
    mode = "markdown";
    trim = {
      methodology = "wrapping";
      wrapping_try_keep_words = false;
    };
  };
  hooks.display_output = "table";
  display_errors = {
    termination_signal = true;
    exit_code = true;
  };
  rm.always_trash = true;
}
