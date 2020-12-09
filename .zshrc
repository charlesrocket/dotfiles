export ZSH=$HOME/.oh-my-zsh
export PATH=/usr/local/bin:/usr/local/sbin:$HOME/.rbenv/bin:$PATH
source $ZSH/oh-my-zsh.sh
ZSH_THEME="gozilla"
DISABLE_AUTO_UPDATE="false"
DISABLE_UPDATE_PROMPT="true"
plugins=(brew direnv git)
eval "$(rbenv init - zsh)"