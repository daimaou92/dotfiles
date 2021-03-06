#!/bin/sh

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

sudo pacman -Sy tmux --noconfirm
S=`scriptDir`
ln -sf "$S/tmux/tmux.conf" "$HOME/.tmux.conf"
