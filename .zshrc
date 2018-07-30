### Settings


# autocompletions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"

# program settings
export EDITOR=vim
export VISUAL=vim
export BROWSER=firefox


### Commands


# drone radio
function dronezone() {
  mplayer http://ice1.somafm.com/dronezone-128-mp3
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
