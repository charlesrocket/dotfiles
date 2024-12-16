typeset -U path
path=(/bin
      /sbin
      /usr/bin
      /usr/sbin
      /usr/local/bin
      /usr/local/sbin
      ~/bin
      ~/.local/bin
      ~/.cargo/bin
      ~/.emacs.d/bin
      $path)
export PATH
export XDG_PICTURES_DIR=$HOME/pictures
export GPG_TTY=$(tty)
export ZSH=$HOME/.oh-my-zsh
export RUST_BACKTRACE=1
eval "$(direnv hook zsh)"
eval "$(rbenv init - zsh)"
ZSH_THEME="gozilla"
DISABLE_AUTO_UPDATE="false"
DISABLE_UPDATE_PROMPT="true"
source $ZSH/oh-my-zsh.sh

if test -z "${XDG_RUNTIME_DIR}"; then
    export XDG_RUNTIME_DIR=/tmp/${UID}-runtime-dir
    if ! test -d "${XDG_RUNTIME_DIR}"; then
        mkdir "${XDG_RUNTIME_DIR}"
        chmod 0700 "${XDG_RUNTIME_DIR}"
    fi
fi
