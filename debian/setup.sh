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

# Setup persistent sharing
EX=`grep "vmhgfs-fuse" /etc/fstab`
[[ ! -z $EX ]] && exit 0
echo "vmhgfs-fuse /mnt/hgfs  fuse defaults,allow_other   0   0" | \
	sudo tee -a /etc/fstab

# Networking
sudo apt install -y network-manager
sudo systemctl enable NetworkManager


# zsh
$SD/zsh.sh

# Xorg
$SD/x.sh

# Tools
$SD/tools.sh
