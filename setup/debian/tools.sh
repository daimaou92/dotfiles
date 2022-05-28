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

/bin/bash "${SD}/alacritty.sh"
/bin/bash "${SD}/nvim.sh"

cd "$SD/../.."
ln -sf "$(pwd)/config/gitconfig" "$HOME/.gitconfig"
mkdir -p "$HOME/.ssh"
