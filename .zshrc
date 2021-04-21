export PATH=/usr/local/bin:/usr/local/sbin:$HOME/.rbenv/bin:$PATH
export ZSH=$HOME/.oh-my-zsh
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export PATH="/usr/local/opt/heroku-node/bin:$PATH"
ZSH_THEME="gozilla"
DISABLE_AUTO_UPDATE="false"
DISABLE_UPDATE_PROMPT="true"
plugins=(brew direnv git)
source $ZSH/oh-my-zsh.sh
eval "$(rbenv init - zsh)"