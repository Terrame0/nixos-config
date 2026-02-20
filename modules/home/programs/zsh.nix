{pkgs, ...}: {
  # -- zsh prompt theme
  programs.starship = {
    enable = true;
  };

  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    history = {
      size = 10000;
      save = 10000;
      path = "$HOME/.zsh_history";
      ignoreDups = true;
      share = true;
    };

    shellAliases = {
      ll = "ls -lh";
      la = "ls -A";
      l = "ls -CF";
      git-log = "git log --oneline --graph --decorate";
    };

    # -- configuration
    initContent = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh | source /dev/stdin

      # -- use starship prompt theme
      eval "$(starship init zsh)"

      # -- emacs-like key bindings
      bindkey -e

      # -- history search with arrows
      autoload -Uz history-substring-search-up
      autoload -Uz history-substring-search-down+
      zle -N history-substring-search-up
      zle -N history-substring-search-down
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      # --

    '';
  };
}
