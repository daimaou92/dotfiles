export ZPLUG_HOME="$ZDOTDIR/.zplug"

autoload -Uz compinit promptinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C
promptinit

zstyle ':completion:*' menu select
source "$ZDOTDIR/main"

# Node
eval "$(fnm env)"
# fix runtime path
ln -sf `which node` $HOME/.local/bin/node

# fzf
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
