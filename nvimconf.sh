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

# neovim
sudo pacman -Sy neovim --noconfirm

# install language servers
npm install -g @tailwindcss/language-server prettier typescript \
	typescript-language-server eslint vscode-langservers-extracted \
	remark-language-server svelte-language-server vim-language-server \
	bash-language-server cssmodules-language-server \
	dockerfile-language-server-nodejs

# go
go install golang.org/x/tools/gopls@latest
go install golang.org/x/tools/cmd/goimports@latest

# sqls
go install github.com/lighttiger2505/sqls@latest

# rust-analyzer
git clone https://github.com/rust-analyzer/rust-analyzer.git
cd rust-analyzer
cargo xtask install --server
cd $P
rm -rf rust-analyzer

# taplo TOML toolkit
cargo install --locked taplo-lsp

# https://github.com/junegunn/vim-plug
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
NVD="$XDG_CONFIG_HOME/nvim"
NVP="$NVD/plugin"
NVL="$NVD/lua/daimaou92"

mkdir -p $NVD
mkdir -p $NVP
mkdir -p $NVL


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
