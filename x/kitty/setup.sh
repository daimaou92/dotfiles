#!/usr/bin/env bash
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
cd $S

theme="dark.conf"
if [[ "$1" == "light" ]]; then
	theme="light.conf"
fi

mkdir -p "$XDG_CONFIG_HOME/kitty"

# Main file
ln -sf "$(pwd)/kitty.conf" "$XDG_CONFIG_HOME/kitty/kitty.conf"
# Theme
ln -sf "$(pwd)/$theme" "$XDG_CONFIG_HOME/kitty/theme.conf"
