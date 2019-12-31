### Settings


# autocompletions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"

# program settings
export EDITOR=vim
export VISUAL=vim
export BROWSER=qutebrowser

# path settings
export PATH=$PATH:$HOME/.yarn/bin:$HOME/.rvm/bin:$HOME/.gem/ruby/2.6.0/bin

# allow using the c-q key
stty -ixon

# fzf
export FZF_DEFAULT_OPTS="--history-size=10000"


### Commands


# soma fm channel
function somafm() {
  mplayer "http://ice1.somafm.com/${1}-${2:-128}-mp3"
}

# drone radio
function dronezone() {
  somafm dronezone
}

# hacker radio
function defconradio() {
  somafm defcon
}


# shortcut for gulp
alias gulp='yarn gulp'

# packer is installed under a different name
alias packer='packer-io'


### Bindings


# vim keybindings
function zle-line-init zle-keymap-select {
    NORMAL_MODE="%F{magenta}NORMAL%f%b"
    INSERT_MODE="%F{blue}INSERT%f%b"
    RPS1="${${KEYMAP/vicmd/$NORMAL_MODE}/(main|viins)/$INSERT_MODE}"
    RPS2=$RPS1
    # PROMPT='>'
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select
bindkey -v


### Third party


# add AWS completion
if [[ -f /usr/bin/aws_zsh_completer.sh ]]; then
  source /usr/bin/aws_zsh_completer.sh
fi

# start ruby version manager
if [ -f "$HOME/.rvm/scripts/rvm" ]; then
  source "$HOME/.rvm/scripts/rvm"
fi
