function zle-line-init zle-keymap-select {
    NORMAL_MODE="%F{magenta}NORMAL%f%b"
    INSERT_MODE="%F{blue}INSERT%f%b"
    RPS1="${${KEYMAP/vicmd/$NORMAL_MODE}/(main|viins)/$INSERT_MODE}"
    RPS2=$RPS1
    zle reset-prompt
}

function yss {
    yaourt -Ss $@ --color | less -R
}

function ys {
    yaourt -S --noconfirm $@
}

zle -N zle-line-init
zle -N zle-keymap-select

compdef _yaourt yss
compdef _yaourt ys

bindkey -v

export ANDROID_HOME=/opt/android-sdk
if [[ -f ~/.private ]]; then
  source ~/.private
fi

# export TEST_REPORTER=nyan

if [[ -f /usr/share/nvm/init-nvm.sh ]]; then
  source /usr/share/nvm/init-nvm.sh
fi

###-begin-npm-completion-###
#
# npm command completion script
#
# Installation: npm completion >> ~/.bashrc  (or ~/.zshrc)
# Or, maybe: npm completion > /usr/local/etc/bash_completion.d/npm
#
which npm &> /dev/null
if [[ $? -eq 0 ]]; then
  if type complete &>/dev/null; then
    _npm_completion () {
      local words cword
      if type _get_comp_words_by_ref &>/dev/null; then
        _get_comp_words_by_ref -n = -n @ -w words -i cword
      else
        cword="$COMP_CWORD"
        words=("${COMP_WORDS[@]}")
      fi

      local si="$IFS"
      IFS=$'\n' COMPREPLY=($(COMP_CWORD="$cword" \
                             COMP_LINE="$COMP_LINE" \
                             COMP_POINT="$COMP_POINT" \
                             npm completion -- "${words[@]}" \
                             2>/dev/null)) || return $?
      IFS="$si"
    }
    complete -o default -F _npm_completion npm
  elif type compdef &>/dev/null; then
    _npm_completion() {
      local si=$IFS
      compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                   COMP_LINE=$BUFFER \
                   COMP_POINT=0 \
                   npm completion -- "${words[@]}" \
                   2>/dev/null)
      IFS=$si
    }
    compdef _npm_completion npm
  elif type compctl &>/dev/null; then
    _npm_completion () {
      local cword line point words si
      read -Ac words
      read -cn cword
      let cword-=1
      read -l line
      read -ln point
      si="$IFS"
      IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                         COMP_LINE="$line" \
                         COMP_POINT="$point" \
                         npm completion -- "${words[@]}" \
                         2>/dev/null)) || return $?
      IFS="$si"
    }
    compctl -K _npm_completion npm
  fi
fi
###-end-npm-completion-###

alias voms='cd ~/programs/stc; pkill -9 node; pkill -9 redis-server; npm run dev-voms'
alias iq='cd ~/programs/stc; pkill -9 node; pkill -9 redis-server; npm run dev-interop'
alias afix='cd ~/programs/stc; pkill -9 node; pkill -9 redis-server; npm run dev-afix'
alias dashboard='cd ~/programs/stc; pkill -9 node; pkill -9 redis-server; npm run dev-dashboard'
alias tests='cd ~/programs/stc; export COVERAGE_DISABLED=1; npm run test'

export EDITOR=nvim
export VISUAL=nvim

export SONAR_SCANNER_HOME="/opt/sonar-scanner"
export PATH="${PATH}:${SONAR_SCANNER_HOME}/bin"
