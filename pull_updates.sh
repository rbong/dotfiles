#!/usr/bin/env bash

set -e

echo pulling dotfiles
cp -f ~/.zshrc ~/.xinitrc ~/.conkyrc .

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

if [[ -d ~/.config/alacritty ]]; then
  echo pulling alacritty config
  cp -R ~/.config/alacritty config
else
  echo skipping ~/.config/alacritty
fi

if [[ -d ~/.config/nvim ]]; then
  echo pulling neovim config
  cp -R ~/.config/nvim config
else
  echo skipping ~/.config/nvim
fi

if [[ -d ~/.local/share/UltiSnips ]]; then
  echo pulling UltiSnips
  cp -R ~/.local/share/UltiSnips .
else
  echo skipping ~/.local/share/UltiSnips
fi
