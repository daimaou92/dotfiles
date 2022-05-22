#!/usr/bin/env bash
set -e
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

# install meson
sudo apt-get install python3 python3-pip python3-setuptools \
                       python3-wheel ninja-build
sudo pip3 install meson

# install i3-gaps
sudo apt install dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev \
	xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev \
	libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev \
	libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev \
	libxcb-shape0 libxcb-shape0-dev
VER=${1:-4.20.1}
TD=`mktemp -d`
cd $TD
git clone https://github.com/Airblader/i3 i3-gaps
cd i3-gaps && git checkout $VER
mkdir -p build && cd build
meson ..
ninja
sudo ninja install
cd $P
sudo rm -rf $TD

# associate config
ln -sf "$SD/x/i3/config" "${XDG_CONFIG_HOME:-$HOME/.config}/i3/config"
