### Settings


# autocompletions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"

# program settings
export EDITOR=vim
export VISUAL=vim
export BROWSER=brave

# path settings
export PATH=$PATH:$HOME/.yarn/bin:$HOME/.rvm/bin


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
source /usr/bin/aws_zsh_completer.sh

# start ruby version manager
source $HOME/.rvm/scripts/rvm
