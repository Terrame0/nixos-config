{...}: {
  programs.git = {
    enable = true;
    settings.user.name = "Terrame0";
    settings.user.email = "terrame_0@proton.me";
    settings = {
      core = {
        editor = "code";
        autocrlf = "input"; # -- turns \r\n into \n in a commit
      };
      init.defaultBranch = "main";
      color.ui = true;
    };
  };
}
