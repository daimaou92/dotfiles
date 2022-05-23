#!/usr/bin/env bash

# Setup persistent sharing
EX=`grep "vmhgfs-fuse" /etc/fstab`
[[ ! -z $EX ]] && exit 0
echo "vmhgfs-fuse /mnt/hgfs  fuse defaults,allow_other   0   0" | \
	sudo tee -a /etc/fstab

# zsh
/bin/bash zsh.sh

# Xorg
/bin/bash x.sh

# Tools
/bin/bash tools.sh
