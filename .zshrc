# General
setopt autocd

bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

# Utilities
printexec() {
	{
		printf "%q " "$@"
		echo
	} >&2
	"$@"
}

alias dotfiles='/usr/bin/git --git-dir="$HOME/.dotfiles/" --work-tree="$HOME"'
alias sa="printexec source ~/.zshrc"

autoload -Uz add-zsh-hook

# Completion
zstyle ":completion:*" matcher-list "m:{[:lower:]}={[:upper:]}"
zstyle ":compinstall" filename "$HOME/.zshrc"

autoload -Uz compinit
compinit

# History
HISTFILE=~/.histfile
HISTSIZE=100000
SAVEHIST=100000

setopt inc_append_history
setopt hist_ignore_dups
setopt hist_find_no_dups

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# Prompt
autoload -Uz vcs_info
add-zsh-hook precmd vcs_info
setopt prompt_subst

zstyle ":vcs_info:*" enable git
zstyle ":vcs_info:*:*" check-for-changes true
zstyle ":vcs_info:git:*" formats "%b%u%c "

PROMPT="%F{blue}%2~%f %F{8}${vcs_info_msg_0_}%f$ "

# Tooling
export GOPATH="$HOME/go"

. "$HOME/.cargo/env"

export NVM_DIR="$HOME/.nvm"
. "$NVM_DIR/nvm.sh"
. "$NVM_DIR/bash_completion"

# Path
typeset -TUx PATH path

path+="$HOME/.local/bin"
path+="$HOME/bin"
