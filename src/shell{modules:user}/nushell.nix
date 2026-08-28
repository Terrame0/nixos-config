{
  lib,
  settings,
  ...
}: let
  inherit (settings) palette;
  style = value:
    lib.hm.nushell.mkNushellInline
    (lib.hm.nushell.toNushell {} value);
in {
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

      color_config = {
        separator = palette.light-gray;
        leading_trailing_space_bg = style {bg = palette.red;};
        header = style {
          fg = palette.blue;
          attr = "b";
        };
        empty = palette.light-gray;
        bool = palette.purple;
        int = palette.purple;
        filesize = palette.purple;
        duration = palette.purple;
        datetime = palette.purple;
        range = palette.purple;
        float = palette.purple;
        string = palette.orange;
        nothing = palette.purple;
        binary = palette.orange;
        binary_null_char = palette.red;
        binary_printable = palette.orange;
        binary_whitespace = palette.light-gray;
        binary_ascii_other = palette.purple;
        binary_non_ascii = palette.yellow;
        "cell-path" = palette.aqua;
        row_index = palette.light-gray;
        record = palette.white;
        list = palette.white;
        closure = palette.orange;
        glob = palette.aqua;
        block = palette.white;
        hints = palette.light-gray;
        search_result = style {
          fg = palette.white;
          bg = palette.dim-gray;
        };
        shape_binary = palette.purple;
        shape_block = palette.white;
        shape_bool = palette.purple;
        shape_closure = palette.orange;
        shape_custom = palette.orange;
        shape_datetime = palette.purple;
        shape_directory = palette.aqua;
        shape_external = palette.orange;
        shape_externalarg = palette.white;
        shape_external_resolved = palette.orange;
        shape_filepath = palette.aqua;
        shape_flag = palette.blue;
        shape_float = palette.purple;
        shape_glob_interpolation = palette.yellow;
        shape_globpattern = palette.aqua;
        shape_int = palette.purple;
        shape_internalcall = palette.orange;
        shape_keyword = palette.purple;
        shape_list = palette.white;
        shape_literal = palette.purple;
        shape_match_pattern = palette.white;
        shape_matching_brackets = style {
          fg = palette.light-gray;
          attr = "u";
        };
        shape_nothing = palette.purple;
        shape_operator = palette.light-gray;
        shape_pipe = palette.light-gray;
        shape_range = palette.purple;
        shape_record = palette.white;
        shape_redirection = palette.light-gray;
        shape_signature = palette.blue;
        shape_string = palette.orange;
        shape_string_interpolation = palette.orange;
        shape_table = palette.white;
        shape_variable = palette.white;
        shape_vardecl = palette.white;
        shape_raw_string = palette.orange;
        shape_garbage = style {
          fg = palette.red;
          attr = "b";
        };
      };
    };

    environmentVariables.LS_COLORS = "rs=0:fi=0:di=36:ln=34:mh=36:pi=33:so=35:bd=33:cd=33:or=31:mi=31:su=31:sg=33:ca=31:tw=36:ow=36:st=36:ex=32";
  };
}
