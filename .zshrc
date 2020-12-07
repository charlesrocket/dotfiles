ZSH_THEME="gozilla"
DISABLE_AUTO_UPDATE="false"
DISABLE_UPDATE_PROMPT="true"
plugins=(git brew)
export PATH="/usr/local/sbin:$PATH"
eval "$(direnv hook zsh)"
eval "$(rbenv init - zsh)"