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

# Dependencies
sudo apt install -y curl build-essential tar gzip

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source $HOME/.cargo/env
rustup default nightly

# Install fnm and latest NodeJS
cargo install fnm
NV=`fnm ls-remote | tail -n1`
fnm install "$NV"
# create $HOME/.local/bin directory for node to symlink to
mkdir -p $HOME/.local/bin

# Install Golang
GV=`git -c 'versionsort.suffix=-' ls-remote --tags --sort='v:refname' \
	https://github.com/golang/go | egrep -e '.*tags/go[0-9.]+$' | \
	tail -n1 | awk '{print $2}' | cut -d'/' -f3`
TD=`mktemp -d`
cd $TD
curl -LO "https://go.dev/dl/${GV}.linux-arm64.tar.gz"
[ -d /usr/local/go ] && sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "${GV}.linux-arm64.tar.gz"
cd $P
rm -rf $TD
# Create GOPATH
mkdir -p $HOME/code/go

export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"
mkdir -p $ZDOTDIR
ln -sf "${SD}/zsh/.zshenv" "$HOME/.zshenv"
cd $SD/zsh/config
for FILE in * .[^.]*; do
	F="$(pwd)/$FILE"
	if [ -f "$F" ]; then
		ln -sf $F "${ZDOTDIR}/$FILE"
	fi
done
cd $P

export ZPLUG_HOME="$ZDOTDIR/.zplug"
[[ -d $ZPLUG_HOME ]] && sudo rm -rf $ZPLUG_HOME
git clone "https://github.com/zplug/zplug" $ZPLUG_HOME
if [[ -z "$(echo $SHELL | grep zsh)" ]]; then
	ZE="$(command -v zsh)"
	[[ -z $ZE ]] && sudo apt install -y zsh
	sudo chsh -s /bin/zsh `whoami`
	echo "zsh installed and changed shell. please re-login"
else
	echo "zsh is current shell"
	source "$ZDOTDIR/.zshrc"
fi
