#!/usr/bin/env bash
set -e
# Source cargo if 'tis there
[[ -d "$HOME/.cargo" ]] && source "$HOME/.cargo/env"

# Check if cargo and rustup are installed
CO=`command -v cargo`
[[ -z $CO ]] && echo "\"cargo\" not found" && exit 1
CO=`command -v rustup`
[[ -z $CO ]] && echo "\"rustup\" not found" && exit 1

sudo apt install -y cmake pkg-config libfreetype6-dev libfontconfig1-dev \
	libxcb-xfixes0-dev libxkbcommon-dev python3 gzip desktop-file-utils

P=`pwd`
TD=`mktemp -d`
cd $TD
git clone https://github.com/alacritty/alacritty.git
cd alacritty
VER=${1:-v0.10.1}
git checkout $VER
rustup override set stable
rustup update stable
cargo build --release
# move to PATH
sudo cp target/release/alacritty /usr/local/bin/

# Check terminfo
CO=`infocmp alacritty`
[[ -z $CO ]] && \
	sudo tic -xe alacritty,alacritty-direct extra/alacritty.info

# Desktop file install
sudo cp extra/logo/alacritty-term.svg /usr/share/pixmaps/Alacritty.svg
sudo desktop-file-install extra/linux/Alacritty.desktop
sudo update-desktop-database

# man page
sudo mkdir -p /usr/local/share/man/man1
gzip -c extra/alacritty.man | sudo tee /usr/local/share/man/man1/alacritty.1.gz > /dev/null
gzip -c extra/alacritty-msg.man | sudo tee /usr/local/share/man/man1/alacritty-msg.1.gz > /dev/null

# zsh completions
ZD="${ZDOTDIR:-$HOME/.config/zsh}"
mkdir -p $ZD/.zsh_functions
cp extra/completions/_alacritty $ZD/.zsh_functions/_alacritty

cd $P
sudo rm -rf $TD
