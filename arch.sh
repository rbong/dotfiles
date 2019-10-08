#!/usr/bin/env bash

set -e

SRCDIR=`pwd`

echo installing arch dependencies

echo creating folder structure
mkdir -p ~/src

echo installing prerequisites
sudo pacman -S base-devel --noconfirm --needed

echo installing AUR helper
curl -fLo /tmp/trizen.tar.gz https://aur.archlinux.org/cgit/aur.git/snapshot/trizen.tar.gz
tar -xzf /tmp/trizen.tar.gz --directory ~/src
cd ~/src/trizen && makepkg -si

echo installing regular dependencies
trizen -S \
  calc \
  grml-zsh-config \
  vim-runtime-git \
  fzf \
  gvim-git \
  pass \
  python-neovim \
  python-greenlet \
  ctags \
  python-pip \
  vifm \
  zsh \
  zsh-autosuggestions \
  zsh-completions \
  --noconfirm \
  --needed


if [[ "$GUI" != "false" ]]; then
  echo installing GUI dependencies
  trizen -S \
    alacritty \
    alsa-utils \
    acpi \
    conky \
    dunst \
    qutebrowser \
    powerline-fonts-git \
    ttf-dejavu \
    ttf-liberation \
    dmenu \
    gimp \
    rambox-bin \
    oomox \
    scrot \
    slock \
    imv \
    mpv \
    gufw \
    xorg \
    xorg-xinit \
    zathura \
    --noconfirm \
    --needed

  # oomox cli ?

  echo installing dwm
  cd "$SRCDIR/dwm-git" && makepkg -sfi && cd ..
fi
