{...}: {
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      "$schema" = "https://starship.rs/config-schema.json";
      format = "$username$git_branch$nix_shell$directory";
      add_newline = false;
      username = {
        show_always = true;
        format = "[ $user](fg:bold green)";
        disabled = false;
      };
      directory = {
        format = "[ at ](fg:white)[  $path](fg:bold cyan)  ";
        truncation_length = 2;
        truncation_symbol = "/";
      };
      git_branch = {
        format = "[ on ](fg:white)[󰘬 $branch](fg:bold yellow)";
      };
      nix_shell = {
        disabled = false;
        format = "[ in ](fg:white)[ $name](fg:bold blue)";
      };
    };
  };
}
