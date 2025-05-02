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
DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"
source $ZSH/oh-my-zsh.sh

if test -z "${HYPRLAND_CMD}"; then
    hyprstart
fi
