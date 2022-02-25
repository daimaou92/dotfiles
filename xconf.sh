#!/usr/bin/env bash

sudo pacman -Sy xorg xorg-xinit i3-gaps i3blocks i3status i3lock feh dex \
	dmenu picom kitty imagemagick libcanberra polkit polkit-gnome \
	xclip --noconfirm

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

S=`scriptDir`
P=`pwd`

# Font


[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
cd $S/x
ln -sf "$(pwd)/.Xresources" "$HOME/.Xresources"
ln -sf "$(pwd)/.xinitrc" "$HOME/.xinitrc"
# sudo cp ./autostart/polkitgnome.desktop /etc/xdg/autostart/polkitgnome.desktop

# Autostart polkit and picom
mkdir -p "$XDG_CONFIG_HOME/autostart"
ln -sf "$(pwd)/autostart/polkitgnome.desktop" \
	"${XDG_CONFIG_HOME}/autostart/polkitgnome.desktop"
ln -sf "$(pwd)/autostart/picom.desktop" \
	"${XDG_CONFIG_HOME}/autostart/picom.desktop"


##################
####### i3 #######
##################
mkdir -p "$XDG_CONFIG_HOME/i3"
cd $S/x/i3 && \
for FILE in * .[^.]*; do
	F="$(pwd)/$FILE"
	if [ -f "$F" ]; then
		ln -sf $F "$XDG_CONFIG_HOME/i3/$FILE"
	fi
done

##################
#### Kitty #######
##################
mkdir -p "$XDG_CONFIG_HOME/kitty"
cd $S/x/kitty && \
for FILE in * .[^.]*; do
	F="$(pwd)/$FILE"
	if [ -f "$F" ]; then
		ln -sf $F "$XDG_CONFIG_HOME/kitty/$FILE"
	fi
done

##################
#### Picom #######
##################
mkdir -p "$XDG_CONFIG_HOME/picom"
cd $S/x/picom && \
ln -sf "$(pwd)/picom.conf" "${XDG_CONFIG_HOME}/picom/picom.conf"

#################
#### Fonts ######
#################

# Install Apple fonts
cd /tmp
git clone https://aur.archlinux.org/apple-fonts.git
cd apple-fonts
makepkg -sircA --noconfirm
cd ../ && rm -rf apple-fonts
cd $P

# Install SF Mono Nerd Patched Font
cd /tmp
git clone https://aur.archlinux.org/nerd-fonts-sf-mono.git
cd nerd-fonts-sf-mono
makepkg -sirc --noconfirm
cd ../ && rm -rf nerd-fonts-sf-mono
cd $P

# enable font config support
sudo mkdir -p /etc/fonts/conf.d
sudo ln -sf /usr/share/fontconfig/conf.avail/50-user.conf \
	/etc/fonts/conf.d/
sudo ln -sf /usr/share/fontconfig/conf.avail/51-local.conf \
	/etc/fonts/conf.d/

# enable sub-pixel rendering (user only)
mkdir -p "$XDG_CONFIG_HOME/fontconfig/conf.d"
ln -sf /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf \
	$XDG_CONFIG_HOME/fontconfig/conf.d/

# custom font config
ln -sf $S/x/fontconfig/fonts.conf "$XDG_CONFIG_HOME/fontconfig/"

#######################
##### Wallpaper #######
#######################
mkdir -p "$HOME/.cache" && cp "${S}/wallpaper.jpg" \
	"$HOME/.cache/.wallpaper.jpg"
feh --bg-fill "$HOME/.cache/.wallpaper.jpg"
[ -f "$HOME/.fehbg" ] && chmod +x "$HOME/.fehbg"

cd $P
