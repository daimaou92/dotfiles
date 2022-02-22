[ -z "${TMUX}" ] && vmhgfs-fuse .host:/ "$HOME/shares" -o subtype=vmhgfs-fuse,allow_other
[ -z "${TMUX}" ] && startx
