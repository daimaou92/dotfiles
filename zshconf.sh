#!/bin/sh
sudo pacman -Sy zsh --noconfirm
sudo chsh -s /bin/zsh `whoami`
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
ln -sf "${SD}/zsh/.zshenv" "$HOME/.zshenv"
cd $SD/zsh
for i in * .[^.]*; do
	F="$(pwd)/$FILE"
	if [ -f "$F" ]; then
		ln -sf $F "${ZDOTDIR}/$FILE"
	fi
done
cd $P

git clone "https://github.com/zplug/zplug" $ZPLUG_HOME
zsh -c source "$ZDOTDIR/.zshrc"
