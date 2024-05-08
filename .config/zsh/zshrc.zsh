#######################################################################################################################
# Setup
#######################################################################################################################

autoload -U compinit && compinit

setopt SHARE_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt APPEND_HISTORY

HISTFILE=~/.history
HISTSIZE=100000
SAVEHIST=100000

bindkey -e

#######################################################################################################################
# Plugins
#######################################################################################################################

[[ ! -d "$HOME/.antigen" ]] && git clone https://github.com/zsh-users/antigen.git "$HOME/.antigen"
source "$HOME/.antigen/antigen.zsh"

antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions

antigen apply

#######################################################################################################################
# Env
#######################################################################################################################

export GOPATH=$HOME/go

export PATH="$PATH:$HOME/.cargo/bin:$HOME/Scripts"

#######################################################################################################################
# Init
#######################################################################################################################

source "$HOME/.cargo/env"

eval "$(starship init zsh)"

eval "$(atuin init zsh --disable-up-arrow)"

eval "$(zoxide init zsh)"
