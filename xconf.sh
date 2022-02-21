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

S=`scriptDir`
P=`pwd`
cd $S/x
ln -sf "$(pwd)/.Xresources" "$HOME/.Xresources"
ln -sf "$(pwd)/.xinitrc" "$HOME/.xinitrc"
cd $P
