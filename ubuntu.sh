#!/usr/bin/env bash

set -e

SRCDIR=`pwd`

echo installing ubuntu dependencies

echo creating folder structure
mkdir -p ~/src

echo updating sources
sudo apt-get update

echo installing programs
sudo apt-get install -y \
  zsh \
  git \
  python \
  python3 \
  golang

echo installing common dependencies
sudo apt-get install -y \
  libncursesw5-dev \
  build-essential

echo installing Go
if [[ ! -d /usr/local/go ]] && [[ ! -d /tmp/go ]]; then
  cd /tmp
  wget "https://dl.google.com/go/go1.12.6.linux-amd64.tar.gz"
  sudo tar -xvf "go1.12.6.linux-amd64.tar.gz"
  sudo cp -r go /usr/local
fi

echo configuring zsh
sudo wget -O /etc/zsh/zshrc "https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc"
if [[ ! -d ~/src/zsh-autosuggestions ]]; then
  git clone "https://github.com/zsh-users/zsh-autosuggestions" ~/src/zsh-autosuggestions
fi
if [[ ! -d /usr/share/zsh/plugins/zsh-autosuggestions ]]; then
  sudo mkdir -p /usr/share/zsh/plugins
  sudo cp -r ~/src/zsh-autosuggestions /usr/share/zsh/plugins/zsh-autosuggestions
fi

echo setting shell to zsh
chsh -s `which zsh`

echo installing fzf
if [[ ! -d ~/src/fzf ]]; then
  git clone --recursive "https://github.com/junegunn/fzf" ~/src/fzf
fi
cd ~/src/fzf
make
make install
sudo cp bin/fzf /usr/local/bin/fzf

echo removing old vim installation
sudo apt-get remove -y vim vim-runtime gvim neovim neovim-runtime

echo installing vim dependencies
  # libgnome2-dev \
  # libgnomeui-dev \
  # libbonoboui2-dev \
sudo apt-get install -y \
  ctags \
  libgtk2.0-dev \
  libatk1.0-dev \
  libcairo2-dev \
  libx11-dev \
  libxpm-dev \
  libxt-dev \
  python-dev \
  python3-dev \
  python3-neovim \
  ruby-dev \
  lua5.1 \
  liblua5.1-dev \
  libperl-dev \
  automake-1.15

echo building vim
if [[ ! -d ~/src/vim ]]; then
  git clone "https://github.com/vim/vim" ~/src/vim
  git checkout v8.1.2424
fi

cd ~/src/vim
./configure \
  --with-features=huge \
  --enable-multibyte \
  --enable-rubyinterp=yes \
  --enable-pythoninterp=yes \
  --enable-python3interp=yes \
  --with-python3-config-dir=/usr/lib/python3.8/config-3.8-x86_64-linux-gnu/ \
  --enable-perlinterp=yes \
  --enable-luainterp=yes \
  --with-luajit \
  --enable-gui=gtk2 \
  --enable-cscope \
  --prefix=/usr/local
make VIMRUNTIMEDIR=/usr/local/share/vim/vim81
sudo make install

echo building vifm
if [[ ! -d ~/src/vifm ]]; then
  git clone "https://github.com/vifm/vifm" ~/src/vifm
fi
cd ~/src/vifm
./configure
make
sudo make install

if [[ "$GUI" != "false" ]]; then
  echo installing GUI dependencies
  echo not implemented on Ubuntu
fi
