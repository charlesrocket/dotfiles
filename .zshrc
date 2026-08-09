[[ -f $HOME/.shrc ]] && . "$HOME/.shrc"

ZSH_CUSTOM=$HOME/.zsh-custom
zstyle ':omz:update' mode auto
zstyle ':omz:update' verbose silent

if [[ "$TERM" = "xterm" ]]; then
    ZSH_THEME="console"
else
    eval "$(starship init zsh)"
fi

eval "$(direnv hook zsh)"
source $ZSH/oh-my-zsh.sh
