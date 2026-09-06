{osConfig, ...}: {
  programs.git = let
    signing-key = osConfig.sops.secrets."git/signing-key".path;
    name = "Terrame0";
    email = "terrame_0@proton.me";
  in {
    enable = true;
    signing = {
      format = "ssh";
      signByDefault = true;
      key = signing-key;
    };
    settings = {
      user = {
        inherit name email;
        signingKey = signing-key;
      };
      core = {
        editor = "code";
        autocrlf = "input";
      };
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = osConfig.sops.secrets."git/allowed-signers".path;
      };
      init.defaultBranch = "main";
      color.ui = true;
    };
  };
}
