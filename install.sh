#!/usr/bin/env bash

set -e

echo moving dotfiles
cp .zshrc .vimrc Xresources .xinitrc .conkyrc ~
mkdir -p ~/.vifm/colors
cp vifmrc ~/.vifm/vifmrc
cp dracula.vifm ~/.vifm/colors
echo done moving dotfiles

echo creating ~/.vim
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/undo

echo copying snippets to ~/.vim/UltiSnips
cp -R UltiSnips ~/.vim

echo setting up dependencies

# https://github.com/junegunn/vim-plug
if [[ ! -f ~/.vim/autoload/plug.vim ]]; then
  echo installing plugged
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo installing vim plugins
  vim -c "PlugInstall | PlugUpdate | qa"
else
  echo updating vim plugins
  vim -c "PlugUpgrade | PlugInstall | PlugUpdate | qa"
fi

echo done setting up dependencies

echo done all
