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

if [ "$1" == "light" ]; then
	"$SD/x/kitty/setup.sh" light
	"$SD/nvimtheme.sh" light
	cd $P
	exit 0
fi

"$SD/x/kitty/setup.sh" dark
"$SD/nvimtheme.sh"  dark
cd $P
