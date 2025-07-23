# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# Universal key bindings for maximum compatibility across terminals and OSes
# Each key has multiple bindings to work everywhere

# Home key (beginning of line)
bindkey "^[[H"    beginning-of-line  # Linux console, some xterms
bindkey "^[[1~"   beginning-of-line  # Most modern terminals (Alacritty, etc)
bindkey "^[OH"    beginning-of-line  # tmux, terminals in application mode
bindkey "^A"      beginning-of-line  # Emacs-style fallback
[[ -n "${key[Home]}" ]] && bindkey -- "${key[Home]}" beginning-of-line

# End key (end of line)
bindkey "^[[F"    end-of-line        # Linux console, some xterms  
bindkey "^[[4~"   end-of-line        # Most modern terminals
bindkey "^[OF"    end-of-line        # tmux, terminals in application mode
bindkey "^E"      end-of-line        # Emacs-style fallback
[[ -n "${key[End]}" ]] && bindkey -- "${key[End]}" end-of-line

# Delete key
bindkey "^[[3~"   delete-char        # Most terminals
[[ -n "${key[Delete]}" ]] && bindkey -- "${key[Delete]}" delete-char

# Insert key
bindkey "^[[2~"   overwrite-mode     # Most terminals
[[ -n "${key[Insert]}" ]] && bindkey -- "${key[Insert]}" overwrite-mode

# Backspace
bindkey "^?"      backward-delete-char # Standard backspace
bindkey "^H"      backward-delete-char # Alternative backspace
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}" backward-delete-char

# Arrow keys (basic movement)
bindkey "^[[D"    backward-char      # Left arrow - most terminals
bindkey "^[OD"    backward-char      # Left arrow - application mode
[[ -n "${key[Left]}" ]] && bindkey -- "${key[Left]}" backward-char

bindkey "^[[C"    forward-char       # Right arrow - most terminals  
bindkey "^[OC"    forward-char       # Right arrow - application mode
[[ -n "${key[Right]}" ]] && bindkey -- "${key[Right]}" forward-char

# Arrow keys for history are handled in zsh-plugins.zsh with history-substring-search
# This provides fallback bindings only if history-substring-search is not available
if ! typeset -f history-substring-search-up > /dev/null; then
    bindkey "^[[A"    up-line-or-history    # Up arrow - most terminals
    bindkey "^[OA"    up-line-or-history    # Up arrow - application mode
    bindkey "^P"      up-line-or-history    # Emacs fallback
    [[ -n "${key[Up]}" ]] && bindkey -- "${key[Up]}" up-line-or-history

    bindkey "^[[B"    down-line-or-history  # Down arrow - most terminals
    bindkey "^[OB"    down-line-or-history  # Down arrow - application mode  
    bindkey "^N"      down-line-or-history  # Emacs fallback
    [[ -n "${key[Down]}" ]] && bindkey -- "${key[Down]}" down-line-or-history
fi

# Page Up/Down
bindkey "^[[5~"   beginning-of-buffer-or-history  # Most terminals
bindkey "^[[6~"   end-of-buffer-or-history        # Most terminals
[[ -n "${key[PageUp]}" ]] && bindkey -- "${key[PageUp]}" beginning-of-buffer-or-history
[[ -n "${key[PageDown]}" ]] && bindkey -- "${key[PageDown]}" end-of-buffer-or-history

# Shift+Tab for reverse completion
bindkey "^[[Z"    reverse-menu-complete           # Most terminals
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}" reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

# Note: Home and End keys are now handled comprehensively above

