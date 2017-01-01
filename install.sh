#!/usr/bin/env bash
echo setting up dependencies...
echo installing plugged...
# https://github.com/junegunn/vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo installing vim plugins...
nvim -c "PlugInstall | qa"
echo done setting up dependencies.

echo moving dotfiles...
cp .zshrc .vimrc .pentadactylrc ~
mkdir -p ~/.vifm
cp vifmrc ~/.vifm/vifmrc
echo done moving dotfiles.

echo linking vim to neovim...
mkdir -p ~/.config/nvim
ln -s ~/.vim ~/.config/nvim
ln -s ~/.vimrc ~/.config/nvim/init.vim
echo done linking.

echo done all.
