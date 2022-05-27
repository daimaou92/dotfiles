#!/usr/bin/env bash
set -e
# Check if xcode-select is installed
V=$(pkgutil --pkg-info=com.apple.pkg.CLTools_Executables | grep version)
[[ -z $V ]] && xcode-select --install

# Dependencies
brew install ninja libtool automake cmake pkg-config gettext curl
brew install --HEAD luajit
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

TD=$(mktemp -d) && cd $TD
git clone https://github.com/neovim/neovim && cd neovim
git checkout nightly
make CMAKE_BUILD_TYPE=Release
sudo make install
cd $P
sudo rm -rf $TD
