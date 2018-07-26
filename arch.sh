#!/usr/bin/env bash

set -e

echo installing arch dependencies
mkdir -p ~/src

echo installing AUR helper
curl -fLo /tmp/trizen.tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/trizen.tar.gz
tar -xzf /tmp/trizen.tar.gz --directory ~/src
cd ~/src/trizen && makepkg -si

echo installing regular dependencies
trizen -S \
  conky \
  dunst \
  grml-zsh-config \
  gvim-git \
  python-pip \
  vifm \
  vim-runtime-git \
  zsh \
  zsh-autosuggestions \
  zsh-completions 


if [[ "$GUI" != "false" ]]; then
  echo installing GUI dependencies
  trizen -S \
    firefox \
    powerline-fonts-git \
    rambox-bin \
    scrot \
    slock
fi

echo installing dwm
