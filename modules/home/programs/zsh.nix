{pkgs, ...}: {
  # -- zsh prompt theme
  programs.starship = {
    enable = true;
  };

  programs.zsh = {
    enable = true;

    # -- autosuggestions
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # plugins = [
    #   {
    #     name = "powerlevel10k";
    #     src = pkgs.zsh-powerlevel10k;
    #     file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
    #   }
    # ];

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

    initContent = ''
      ${pkgs.any-nix-shell}/bin/any-nix-shell zsh --info-right | source /dev/stdin
      # -- use starship prompt theme
      eval "$(starship init zsh)"
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
