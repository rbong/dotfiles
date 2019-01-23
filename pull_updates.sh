#!/usr/bin/env bash

set -e

echo pulling dotfiles
cp ~/.zshrc ~/.vimrc ~/.Xresources ~/.xinitrc ~/.conkyrc ~/.cvimrc .

if [[ -f ~/.vifm/vifmrc ]]; then
  echo pulling vfmrc
  cp ~/.vifm/vifmrc .
else
  echo skipping ~/.vifm/vifmrc
fi

if [[ -d ~/.vim/UltiSnips ]]; then
  echo pulling UltiSnips
  cp -R ~/.vim/UltiSnips .
else
  echo skipping ~/.vim/UltiSnips
fi
