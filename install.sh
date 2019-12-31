#!/usr/bin/env bash

set -e

echo moving dotfiles
cp .zshrc .vimrc .xinitrc .conkyrc ~
mkdir -p ~/.vifm/colors
cp vifmrc ~/.vifm/vifmrc
cp gruvbox.vifm ~/.vifm/colors
echo done moving dotfiles

echo creating ~/.vim
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/undo

echo copying snippets to ~/.vim/UltiSnips
cp -R UltiSnips ~/.vim

echo moving config files
mkdir -p ~/.config
cp -R config/* ~/.config
echo done moving config files

echo setting up dependencies

if [[ ! -d ~/.config/qutebrowser/jblock ]]; then
  echo installing jblock
  git clone https://gitlab.com/jgkamat/jblock.git ~/.config/qutebrowser/jblock
  echo done installing jblock
else
  echo updating jblock
  cd ~/.config/qutebrowser/jblock && git pull
  echo done updating jblock
fi

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
