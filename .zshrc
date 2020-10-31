ZSH_THEME="flazz"
DISABLE_UPDATE_PROMPT=true
plugins=(git)
source $ZSH/oh-my-zsh.sh
export PATH="/usr/local/sbin:$PATH"
eval "$(direnv hook zsh)"
