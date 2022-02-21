[ -z "${TMUX}" ] && vmhgfs-fuse .host:/ /home/abhishek/shares -o subtype=vmhgfs-fuse,allow_other
[ -z "${TMUX}" ] && startx
