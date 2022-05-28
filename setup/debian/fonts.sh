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

SD=`scriptDir`
P=`pwd`

# deps
sudo apt install -y p7zip-full curl unzip
TF="$SD/ftmp"
rm -rf $TF
mkdir -p "$TF/fontfiles" && cd $TF

curl -O https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg
7z x SF-Pro.dmg
cd SFProFonts
7z x 'SF Pro Fonts.pkg'
7z x 'Payload~'
mv Library/Fonts/* $TF/fontfiles/
cd ..

curl -O https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg
7z x SF-Compact.dmg
cd SFCompactFonts
7z x 'SF Compact Fonts.pkg'
7z x 'Payload~'
mv Library/Fonts/* $TF/fontfiles/
cd ..

curl -O https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg
7z x SF-Mono.dmg
cd SFMonoFonts
7z x 'SF Mono Fonts.pkg'
7z x 'Payload~'
mv Library/Fonts/* $TF/fontfiles
cd ..

curl -O https://devimages-cdn.apple.com/design/resources/download/NY.dmg
7z x NY.dmg
cd NYFonts
7z x 'NY Fonts.pkg'
7z x 'Payload~'
mv Library/Fonts/* $TF/fontfiles
cd ..

rm -r *.dmg NYFonts SFCompactFonts SFProFonts SFMonoFonts

sudo mkdir -p /usr/share/fonts/OTF /usr/share/fonts/TTF

sudo mv $TF/fontfiles/*.otf /usr/share/fonts/OTF
sudo mv $TF/fontfiles/*.ttf /usr/share/fonts/TTF
rm -rf $TF/fontfiles

# Hack
curl -LO "https://github.com/ryanoasis/nerd-fonts/releases/download/2.2.0-RC/Hack.zip"
unzip Hack.zip -d Hack
rm "Hack/"*"Windows Compatible.ttf"
sudo install -Dm644 "Hack/"*.ttf /usr/share/fonts/TTF

cd $P
rm -rf $TF

# Regenerate font cache
fc-cache -f

CH="${XDG_CONFIG_HOME:-$HOME/.config}"
mkdir -p $CH/fontconfig

cd $SD/../../config
ln -sf "$(pwd)/fontconfig/fonts.conf" "$CH/fontconfig/fonts.conf"

cd $P
