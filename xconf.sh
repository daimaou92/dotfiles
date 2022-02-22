#!/usr/bin/env bash

sudo pacman -Sy xorg xorg-xinit i3-gaps i3blocks i3status i3lock feh dex \
	dmenu picom kitty imagemagick libcanberra polkit polkit-gnome \
	xclip --noconfirm

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

S=`scriptDir`
P=`pwd`
cd $S/x
ln -sf "$(pwd)/.Xresources" "$HOME/.Xresources"
ln -sf "$(pwd)/.xinitrc" "$HOME/.xinitrc"
sudo cp ./autostart/polkitgnome.desktop /etc/xdg/autostart/polkitgnome.desktop

[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
mkdir -p "$XDG_CONFIG_HOME/i3"
cd $S/x/i3 && \
for FILE in * .[^.]*; do
	F="$(pwd)/$FILE"
	if [ -f "$F" ]; then
		ln -sf $F "$XDG_CONFIG_HOME/i3/$FILE"
	fi
done

mkdir -p "$XDG_CONFIG_HOME/kitty"
cd $S/x/kitty && \
for FILE in * .[^.]*; do
	F="$(pwd)/$FILE"
	if [ -f "$F" ]; then
		ln -sf $F "$XDG_CONFIG_HOME/kitty/$FILE"
	fi
done
cd $P
