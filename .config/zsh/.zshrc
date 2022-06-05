zmodload zsh/zprof

source $ZDOTDIR/zsh_functions
set -o extendedglob # make glob matching more epic


# Colors
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}λ%b "
setopt autocd # Automatically cd into typed directory.
stty stop undef # Disable ctrl-s to freeze terminal.
setopt interactive_comments


# Source all other files
source "$HOME/.config/shell/profile" # needs to be set before alias
source "$XDG_CONFIG_HOME/shell/alias"
source "$ZDOTDIR/zsh_startup"
source $XDG_CONFIG_HOME/lf/LF_ICONS

source "$ZDOTDIR/zsh_completions" # Calls  compinit
source "$ZDOTDIR/zsh_cleanup" # Compinit (needs to be set before vi mode)
source "$ZDOTDIR/zsh_history"
source "$ZDOTDIR/zsh_vi_mode"

source "$XDG_CONFIG_HOME/shell/shortcut"
source "$XDG_CONFIG_HOME/shell/functions"
source "$ZDOTDIR/zsh_keybindings"

# Plugins installed by package manager
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh

# zprof
