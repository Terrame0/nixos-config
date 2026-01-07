{...}: {
  programs.zsh = {
    enable = true;

    # -- autosuggestions
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # -- plugin manager
    antidote = {
      enable = true;
      plugins = [
        "romkatv/powerlevel10k"
      ];
    };

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

    # -- environment
    initContent = ''
      # -- better key bindings
      bindkey -e
      # -- history search with arrows
      autoload -Uz up-line-or-beginning-search
      autoload -Uz down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey '^[[A' up-line-or-beginning-search
      bindkey '^[[B' down-line-or-beginning-search
    '';
  };
}
