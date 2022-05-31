source $ZDOTDIR/zsh_functions
set -o extendedglob ***REMOVED*** make glob matching more epic


***REMOVED*** Colors
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}λ%b "
setopt autocd		***REMOVED*** Automatically cd into typed directory.
stty stop undef		***REMOVED*** Disable ctrl-s to freeze terminal.
setopt interactive_comments


***REMOVED*** Source all other files
zsh_add_file "$HOME/.config/shell/profile" ***REMOVED*** needs to be set before alias
zsh_add_file "$XDG_CONFIG_HOME/shell/alias"
zsh_add_file "$XDG_CONFIG_HOME/shell/startup"
source $XDG_CONFIG_HOME/lf/LF_ICONS

zsh_add_file "$ZDOTDIR/zsh_completions" ***REMOVED*** Calls  compinit
zsh_add_file "$ZDOTDIR/zsh_cleanup" ***REMOVED*** Compinit (needs to be set before vi mode)
zsh_add_file "$ZDOTDIR/zsh_history"
zsh_add_file "$ZDOTDIR/zsh_vi_mode"

zsh_add_file "$XDG_CONFIG_HOME/shell/shortcut"
zsh_add_file "$XDG_CONFIG_HOME/shell/functions"
zsh_add_file "$ZDOTDIR/zsh_keybindings"

***REMOVED*** Plugins installed by package manager
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
