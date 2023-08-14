#!/usr/bin/env bash

set -e

echo moving dotfiles
cp .zshrc .xinitrc .conkyrc ~
mkdir -p ~/.vifm/colors
cp vifmrc ~/.vifm/vifmrc
cp gruvbox.vifm ~/.vifm/colors
echo done moving dotfiles

echo creating ~/.vim
mkdir -p ~/.vim/swap
mkdir -p ~/.vim/undo

echo copying snippets to ~/.local/share/UltiSnips
cp -R UltiSnips ~/.local/share

echo moving config files
mkdir -p ~/.config
cp -R config/* ~/.config
echo done moving config files

echo installing binaries
sudo cp bin/* /usr/local/bin
echo done installing binaries

echo setting up dependencies

# https://github.com/wbthomason/packer.nvim
PACKER_DIR="~/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [[ ! -f "${PACKER_DIR}" ]]; then
  echo installing plugged
  git clone --depth 1 "https://github.com/wbthomason/packer.nvim" "${PACKER_DIR}"
  echo installing vim plugins
else
  echo updating vim plugins
fi
nvim -c "PackerSync | qa"

echo done setting up dependencies

echo done all
