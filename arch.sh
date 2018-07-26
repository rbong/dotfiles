#!/usr/bin/env bash

set -e

echo installing arch dependencies
mkdir -p ~/src

echo installing prerequisites
sudo pacman -S base-devel --noconfirm

echo installing AUR helper
curl -fLo /tmp/trizen.tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/trizen.tar.gz
tar -xzf /tmp/trizen.tar.gz --directory ~/src
cd ~/src/trizen && makepkg -si

echo installing regular dependencies
trizen -S \
  conky \
  dunst \
  grml-zsh-config \
  vim-runtime-git \
  gvim-git \
  python-pip \
  vifm \
  zsh \
  zsh-autosuggestions \
  zsh-completions \
  --noconfirm


if [[ "$GUI" != "false" ]]; then
  echo installing GUI dependencies
  trizen -S \
    firefox \
    powerline-fonts-git \
    rambox-bin \
    scrot \
    slock \
    --noconfirm

  echo installing dwm
  cd dwm-git && makepkg -sfi

  echo installing firefox theme
  cd ../vim-vixen-dracula && ./install.sh
fi
