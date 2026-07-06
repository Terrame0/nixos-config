{...}: {
  programs.git = {
    enable = true;
    settings.user.name = "Terrame0";
    settings.user.email = "terrame_0@proton.me";
    settings = {
      core = {
        editor = "code";
        autocrlf = "input";
      };
      init.defaultBranch = "main";
      color.ui = true;
    };
  };
}
