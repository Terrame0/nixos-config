{ pkgs, ... }:
{
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

      # -- signal rebinding
      stty intr '^X'
      stty susp '^P'

      # -- history search with arrows
      autoload -Uz history-substring-search-up
      autoload -Uz history-substring-search-down
      zle -N history-substring-search-up
      zle -N history-substring-search-down
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      # -- autocomplete behaviour
      bindkey '^[[Z' expand-or-complete

      accept-completion() {} # -- dummy widget
      zle -N accept-completion
      ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(accept-completion)
      bindkey '^I' accept-completion

      # -- cursor movement
      make-move-widget() {
        local name=$1 base=$2
        eval "
          $name() {
            (( REGION_ACTIVE )) && zle deactivate-region
            zle $base
          }
          zle -N $name
        "
      }

      for key base in \
        '^[OD' backward-char \
        '^[OC' forward-char \
        '^[[1;5D' backward-word \
        '^[[1;5C' forward-word \
        '^[[1;3D' beginning-of-line \
        '^[[1;3C' end-of-line
      do
        name="move-$base"
        make-move-widget $name $base
        bindkey $key $name
      done

      # -- fix autocomplete accept not working on right arrow press
      ZSH_AUTOSUGGEST_ACCEPT_WIDGETS+=(move-forward-char move-end-of-line)
      ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS+=(move-forward-word)

      # -- selection
      make-select-widget() {
        local name=$1 base=$2
        eval "
          $name() {
            (( REGION_ACTIVE )) || zle set-mark-command
            zle $base
          }
          zle -N $name
        "
      }

      for key base in \
        '^[[1;2D' backward-char \
        '^[[1;2C' forward-char \
        '^[[1;6D' backward-word \
        '^[[1;6C' forward-word
      do
        name="select-$base"
        make-select-widget $name $base
        bindkey $key $name
      done


      # -- char deletion
      bindkey '^H' backward-kill-word
      bindkey '^[^H' backward-kill-line
      bindkey '^[[3;5~' kill-word
      bindkey '^[[3;7~' kill-line
      bindkey '^Z' undo
      bindkey '^[^Z' redo
    '';
  };
}
