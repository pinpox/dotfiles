# Prevents grep options deprecation message
unset GREP_OPTIONS

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# History search
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey "$terminfo[kcuu1]" up-line-or-beginning-search
bindkey "$terminfo[kcud1]" down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down


export SUDO_ASKPASS="/home/binaryplease/.local/bin/passsudo"
export EDITOR=/usr/bin/nvim
export GOPATH=~/.go

# Keep .local/bin befor .go/bin to set correct antibody location
export PATH="$PATH:\
.local/bin:\
/usr/bin/core_perl:\
/usr/bin/site_perl:\
/usr/bin/vendor_perl:\
/usr/bin:\
.go/bin:\
/usr/lib/jvm/default/bin:\
/usr/local/bin:\
/usr/local/sbin"
export VISUAL=/usr/bin/nvim
PATH="$PATH:$(ruby -e 'print Gem.user_dir')/bin"
export GEM_HOME=$HOME/.gem

ZSH="$(antibody home)/https-COLON--SLASH--SLASH-github.com-SLASH-robbyrussell-SLASH-oh-my-zsh"
# Dynamic loading (slower)
# source <(antibody init)
# antibody bundle < ~/.zsh_plugins

# Static loading, run:
# antibody bundle < ~/.zsh_plugins > ~/.zsh_plugins.sh
# if new plugins are added
source ~/.zsh_plugins.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.fzf.colors ] && source ~/.fzf.colors

source ~/.zsh_functions
source ~/.zsh_aliases

if [[ ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi

export GPG_TTY=$(tty)
# PROMPT='$(gbt $?)'
# autoload -Uz add-zsh-hook
# prompt_mimir_cmd() { /home/binaryplease/.go/bin/mimir }
# add-zsh-hook precmd prompt_mimir_cmd

# prompt_symbol='❯'
# PROMPT='%(?.%F{magenta}.%F{red})${prompt_symbol}%f '
SSH_AUTH_SOCK=/run/user/1000/gnupg/S.gpg-agent.ssh; export SSH_AUTH_SOCK;
