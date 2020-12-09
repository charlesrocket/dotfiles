export PATH=/usr/local/bin:/usr/local/sbin:$HOME/.rbenv/bin:$PATH
export ZSH=$HOME/.oh-my-zsh
ZSH_THEME="gozilla"
DISABLE_AUTO_UPDATE="false"
DISABLE_UPDATE_PROMPT="true"
plugins=(brew direnv git)
source $ZSH/oh-my-zsh.sh
eval "$(rbenv init - zsh)"