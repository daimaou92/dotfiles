#!/bin/sh
echo "Installing kitty..."
sudo pacman -Sy --noconfirm --quiet python harfbuzz zlib libpng lcms2 librsync \
	freetype2 fontconfig libcanberra imagemagick python-pygments curl \
	> /dev/null 2>&1 || \
	echo "Installing dependencies failed" || \
	exit 1
curl -sL https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin \
	> /dev/null 2>&1 || \
	echo "Kitty install script failed" || \
	exit 1
sudo ln -sf "$HOME/.local/kitty.app/bin/kitty" /usr/bin/kitty
echo "Success"
