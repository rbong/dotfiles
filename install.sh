#!/usr/bin/env bash
echo moving dotfiles...
cp .zshrc .vimrc
mkdir -p ~/.vifm
cp vifmrc ~/.vifm/vifmrc
echo done moving dotfiles.

echo creating ~/.vim
mkdir -p ~/.vim

echo setting up dependencies...
echo installing plugged...
# https://github.com/junegunn/vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo installing vim plugins...
vim -c "PlugInstall | qa"
echo done setting up dependencies.

echo done all.
