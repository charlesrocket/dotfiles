ZSH_CUSTOM=$HOME/.zsh-custom
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"

if [[ "$TERM" = "xterm" ]]; then
    ZSH_THEME="console"
else
    ZSH_THEME="chuck"
fi

eval "$(direnv hook zsh)"
export GPG_TTY=$(tty)
source $ZSH/oh-my-zsh.sh
