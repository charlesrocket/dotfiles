ZSH_THEME="gozilla"
DISABLE_AUTO_UPDATE="false"
DISABLE_UPDATE_PROMPT="true"
plugins=(brew git direnv)
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/.rbenv/bin:$PATH
eval "$(rbenv init - zsh)"