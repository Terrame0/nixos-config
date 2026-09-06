{...}: {
  show_banner = false;
  history = {
    max_size = 10000;
    sync_on_enter = true;
    file_format = "sqlite";
    isolation = false;
  };
  use_ansi_coloring = true;
  table = {
    missing_value_symbol = "<>";
    mode = "restructured";
    trim = {
      methodology = "wrapping";
      wrapping_try_keep_words = false;
    };
  };
  display_errors = {
    termination_signal = true;
    exit_code = true;
  };
  rm.always_trash = true;
}
