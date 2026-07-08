{pkgs, ...}: {
  programs.claude-code = {
    enable = true;
    package = pkgs.claude-code;
    settings = {
      theme = "dark";
      suggestions = false;
      includeCoAuthoredBy = false;
      permissions = {
        allow = [
          "Bash(git diff:*)"
          "Bash(git log:*)"
          "Bash(git status:*)"
          "Bash(nix eval:*)"
          "Bash(nix build:*)"
          "Bash(alejandra:*)"
        ];
        ask = [
          "Bash(git push:*)"
          "Bash(git commit:*)"
        ];
        deny = [
          "Read(./secrets/**)"
          "Read(**/*.yaml)"
        ];
      };
    };
  };
}
