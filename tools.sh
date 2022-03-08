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

S=`scriptDir`
P=`pwd`

# protocol buffers
PV=`git -c 'versionsort.suffix=-' ls-remote --tags --sort='v:refname' \
        https://github.com/protocolbuffers/protobuf | \
		egrep -e 'v[0-9]+\.[0-9]+\.[0-9]+$' | \
		awk '{print $2}' | cut -d'/' -f3 | tail -n1 | cut -d'v' -f2`
L="https://github.com/protocolbuffers/protobuf/releases/download/v${PV}/protoc-${PV}-linux-aarch_64.zip"
sudo pacman -Sy unzip wget --noconfirm
wget --no-dns-cache --no-check-certificate --debug $L
D="$HOME/.local/protoc"
[ -d $D ] && rm -rf $D
unzip "./protoc-${PV}-linux-aarch_64.zip" -d $D
rm "./protoc-${PV}-linux-aarch_64.zip"

if [ ! -z "$(command -v go)" ];  then
	go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
fi

if [ ! -z "$(command -v npm)" ]; then
	npm i -g protobufjs
fi



