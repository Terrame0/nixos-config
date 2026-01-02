{...}: {
  programs.git = {
    enable = true;
    userName = "Terrame0";
    userEmail = "terrame_0@proton.me";
    extraConfig = {
      core = {
        editor = "code";
        autocrlf = "input"; # -- turns \r\n into \n in a commit
      };
      init.defaultBranch = "main";
      color.ui = true;
    };
  };
}
