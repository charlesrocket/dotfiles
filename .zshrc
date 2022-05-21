export PATH=/usr/local/bin:/usr/local/sbin:$HOME/.rbenv/bin:$PATH
export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"
export PATH="/usr/local/opt/arm-gcc-bin@8/bin:$PATH"
export ZSH=$HOME/.oh-my-zsh
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/opt/openssl/lib/pkgconfig
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"
export PATH="/usr/local/opt/heroku-node/bin:$PATH"
ZSH_THEME="gozilla"
DISABLE_AUTO_UPDATE="false"
DISABLE_UPDATE_PROMPT="true"
plugins=(brew direnv git)
source $ZSH/oh-my-zsh.sh
eval "$(rbenv init - zsh)"
