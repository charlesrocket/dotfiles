ZSH_CUSTOM=$HOME/.zsh-custom
zstyle ':omz:update' mode disabled

if [[ "$TERM" = "xterm" ]]; then
    ZSH_THEME="console"
else
    eval "$(starship init zsh)"
fi

eval "$(direnv hook zsh)"
export GPG_TTY=$(tty)
source $ZSH/oh-my-zsh.sh
