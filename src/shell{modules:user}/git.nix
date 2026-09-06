{osConfig, ...}: {
  programs.git = let
    signature-key = osConfig.sops.secrets."ssh/github-key-pub".path;
  in {
    enable = true;
    signing = {
      format = "ssh";
      signByDefault = true;
      key = signature-key;
    };
    settings = {
      user = {
        name = "Terrame0";
        email = "terrame_0@proton.me";
        signingKey = signature-key;
      };
      core = {
        editor = "code";
        autocrlf = "input";
      };
      gpg.format = "ssh";
      init.defaultBranch = "main";
      color.ui = true;
    };
  };
}
