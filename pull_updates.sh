#!/usr/bin/env bash

set -e

echo pulling dotfiles
cp -f ~/.zshrc ~/.vimrc ~/.Xresources* ~/.xinitrc ~/.conkyrc ~/.cvimrc .

if [[ -f ~/.vifm/vifmrc ]]; then
  echo pulling vfmrc
  cp ~/.vifm/vifmrc .
else
  echo skipping ~/.vifm/vifmrc
fi

if [[ -d ~/.config/git ]]; then
  echo pulling git config
  cp -R ~/.config/git config
else
  echo skipping ~/.config/git
fi

if [[ -d ~/.config/qutebrowser ]]; then
  echo pulling qutebrowser config
  cp -R ~/.config/qutebrowser config
else
  echo skipping ~/.config/qutebrowser
fi

if [[ -d ~/.vim/UltiSnips ]]; then
  echo pulling UltiSnips
  cp -R ~/.vim/UltiSnips .
else
  echo skipping ~/.vim/UltiSnips
fi
