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

P=`pwd`
SD=`scriptDir`

theme="dark.vim.nl"
if [ "$1" == "light" ]; then
	theme="light.vim.nl"
fi

mkdir -p "$XDG_CONFIG_HOME/nvim"
cd "$SD/nvim/plugin"
ln -sf "$(pwd)/$theme" "$XDG_CONFIG_HOME/nvim/plugin/colors.vim"
cd $P
