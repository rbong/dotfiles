### Settings


# autocompletions
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=10"

# program settings
export EDITOR=vim
export VISUAL=vim
export BROWSER=qutebrowser

# path settings
export PATH=$PATH:$HOME/.local/bin:$HOME/.yarn/bin:$HOME/.rvm/bin:$HOME/.gem/ruby/2.6.0/bin:$HOME/.pyenv/bin:$HOME/.nvm/versions/node/v14.17.4/bin

# allow using the c-q key
stty -ixon

# fzf
export FZF_DEFAULT_OPTS="--history-size=10000"

# fix certain Java programs
export _JAVA_AWT_WM_NONREPARENTING=1

# Set up X server on Windows
# export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
# export LIBGL_ALWAYS_INDIRECT=true

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

# add gcloud completion
if [ -f /opt/google-cloud-sdk/completion.zsh.inc ]; then
  source /opt/google-cloud-sdk/completion.zsh.inc
fi

# start ruby version manager
if [ -f "$HOME/.rvm/scripts/rvm" ]; then
  source "$HOME/.rvm/scripts/rvm"
fi

# start node version manager
if [ -f "$HOME/.nvm/nvm.sh" ]; then
  source "$HOME/.nvm/nvm.sh"
fi

# start pyenv
if [ -d "$HOME/.pyenv" ]; then
  eval "$(pyenv init -)"
fi

# terraform autocompletion
complete -o nospace -C /usr/bin/terraform terraform

autoload -U +X bashcompinit && bashcompinit
