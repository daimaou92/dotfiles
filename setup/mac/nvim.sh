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

CD="${XDG_CONFIG_HOME:-$HOME/.config}"
rm -rf $CD/nvim
mkdir -p $CD/nvim/lua/daimaou92

# Tools
brew install ripgrep fd

# gopls
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest

# rust analyzer
TD=`mktemp -d`
cd $TD
git clone https://github.com/rust-analyzer/rust-analyzer.git
cd rust-analyzer
cargo xtask install --server
cd $P
rm -rf $TD

# Vim Plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
NVD="$CD/nvim"
mkdir -p $NVD

NVL="$NVD/lua/daimaou92"
mkdir -p $NVL

cd $SD/../../config/nvim
for FILE in * .[^.]*; do
	F="$(pwd)/$FILE"
	if [ -f "$F" ]; then
		ln -sf $F "${NVD}/$FILE"
	fi
done

cd $SD/../../config/nvim/lua/daimaou92
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
