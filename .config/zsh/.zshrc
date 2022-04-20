source $ZDOTDIR/zsh_functions
set -o extendedglob # make glob matching more epic


# Colors
autoload -U colors && colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}λ%b "
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments


# Source all other files
zsh_add_file "shell/profile" # needs to be set before alias
zsh_add_file "shell/alias"
zsh_add_file "shell/startup"
source $HOME/.config/lf/LF_ICONS

zsh_add_file "zsh_completions" # Calls  compinit
zsh_add_file "zsh_cleanup" # Compinit (needs to be set before vi mode)
zsh_add_file "zsh_history"
zsh_add_file "zsh_keybindings"
zsh_add_file "zsh_vi_mode"


# Plugins installed by package manager
source /usr/share/zsh/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
