#!/bin/sh
export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
mkdir -p $ZDOTDIR

export ZPLUG_HOME="$ZDOTDIR/.zplug"

scriptDir() {
	P=`pwd`
	D="$(dirname $0)"
	if [[ $D == /* ]]; then
		echo $D
	elif [[ $D == \.* ]]; then
		J=`echo "$D" | sed 's/.//'`
		echo "${P}$J"
	else
		echo "${P}/$D"
	fi
}

P=`pwd`
SD=`scriptDir`

# $HOME/shares is used to mount shared folders from vmware
mkdir -p $HOME/shares

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
# fnm
cargo install fnm
NV=`fnm ls-remote | tail -n1`
fnm install "$NV"
# create $HOME/.local/bin directory for node to symlink to
mkdir $HOME/.local/bin

# golang
# use below to install latest version of go
# GV=`git -c 'versionsort.suffix=-' ls-remote --tags --sort='v:refname' \
# 	https://github.com/golang/go | egrep -e '.*tags/go[0-9.]+$' | \
# 	tail -n1 | awk '{print $2}' | cut -d'/' -f3`
TD=`mktemp -d`
cd $TD
# Installing go1.17.7
wget "https://go.dev/dl/go1.17.7.linux-arm64.tar.gz"
[ -d /usr/local/go ] && sudo rm -rf /usr/local/go
sudo pacman -Sy tar gzip --noconfirm
sudo tar -C /usr/local -xzf "go1.17.7.linux-arm64.tar.gz"
cd $P
rm -rf $TD

ln -sf "${SD}/zsh/.zshenv" "$HOME/.zshenv"
cd $SD/zsh
for FILE in * .[^.]*; do
	F="$(pwd)/$FILE"
	if [ -f "$F" ]; then
		ln -sf $F "${ZDOTDIR}/$FILE"
	fi
done
cd $P

git clone "https://github.com/zplug/zplug" $ZPLUG_HOME

if [ ! -z "$(echo $0 | grep zsh)" ]; then
	source "$ZDOTDIR/.zshrc"
else
	echo "please install zsh and change shell"
fi
