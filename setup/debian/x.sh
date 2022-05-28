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

sudo apt install -y open-vm-tools-desktop xclip policykit-1-gnome xorg xinit \
x11-xserver-utils build-essential git wget curl tmux dex dunst feh

# i3-gaps
/bin/bash "$SD/i3.sh"

# wallpaper
mkdir -p $HOME/.cache
cp "$SD/x/wallpaper.jpg" "$HOME/.cache/.wallpaper.jpg"
echo -e "#!/bin/sh\n\
feh --no-fehbg --bg-fill '$HOME/.cache/.wallpaper.jpg'" > \
	$HOME/.fehbg
[ -f "$HOME/.fehbg" ] && chmod +x "$HOME/.fehbg"

# Fonts
/bin/bash "$SD/fonts.sh"

# move to dotfiles dir
cd "$SD/../../"
# xinit
ln -sf "$(pwd)/config/x/xinitrc" "$HOME/.xinitrc"

# Resolution
ln -sf "$(pwd)/config/x/Xresources" "$HOME/.Xresources"

# tmux
ln -sf "$(pwd)/config/x/tmux.conf" "$HOME/.tmux.conf"

cd $P
