export ZSH="/Users/rocket/.oh-my-zsh"
ZSH_THEME="flazz"
plugins=(git)
source $ZSH/oh-my-zsh.sh
export PATH="/usr/local/sbin:$PATH"
eval "$(direnv hook zsh)"
[ -f /Users/rocket/.travis/travis.sh ] && source /Users/rocket/.travis/travis.sh
