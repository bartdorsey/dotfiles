# Profiler
zmodload zsh/zprof

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [[ ! "$TERM_PROGRAM" =~ "vscode" ]]&& [ -z "$TMUX" ]; then
  exec tmux -u new -As default
else

    # Skip global compinit initialization in Ubuntu
    skip_global_compinit=1
    # Load zsh functions
    source $ZDOTDIR/zsh-functions.sh

    # Configure colors for zsh
    autoload -U colors && colors

    # Configure LS_COLORS
    if type dircolors > /dev/null; then
        eval $(dircolors)
    fi

    # Configure zmv
    autoload zmv

    # Configure completion for zsh
    zsh_configure_completion > /dev/null 2>&1

    # Stop Ctrl-S freezing the terminal
    stty stop undef

    # Plugins
    zsh_config_run zsh-plugins.sh

    # Prompt
    zsh_config_run starship.zsh

    # MOTD
    zsh_config_run macchina.zsh

    # Run compinit
    compinit

fi

    # End Profiler
    #zprof
