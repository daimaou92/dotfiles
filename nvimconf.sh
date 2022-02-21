#!/usr/bin/env bash
# neovim
sudo pacman -Sy neovim --noconfirm
# https://github.com/junegunn/vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
NVD="$XDG_CONFIG_HOME/nvim"
NVP="$NVD/plugin"
NVL="$NVD/lua/daimaou92"

mkdir -p $NVD
mkdir -p $NVP
mkdir -p $NVL

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
cd $SD/nvim
for FILE in * .[^.]*; do
	F="$(pwd)/$FILE"
	if [ -f "$F" ]; then
		ln -sf $F "${NVD}/$FILE"
	fi
done

cd $SD/nvim/plugin
for FILE in * .[^.]*; do
	F="$(pwd)/$FILE"
	if [ -f "$F" ]; then
		ln -sf $F "${NVP}/$FILE"
	fi
done

cd $SD/nvim/lua/daimaou92
for FILE in * .[^.]*; do
	F="$(pwd)/$FILE"
	if [ -f "$F" ]; then
		ln -sf $F "${NVL}/$FILE"
	fi
done
cd $P
$(which nvim) -c "PlugInstall" -c "q!" -c "q!"
$(which nvim) \
	-c "TSInstallSync! go html javascript json make rust svelte toml yaml" \
	-c "q!"
