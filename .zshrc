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

DISABLE_AUTO_UPDATE="true"
DISABLE_UPDATE_PROMPT="true"

#if test -z "${HYPRLAND_CMD}"; then
    #hyprstart
#fi

if [[ "$TERM" = "xterm" ]]; then
    ZSH_THEME="lambda"
else
    ZSH_THEME="gozilla"
fi

source $ZSH/oh-my-zsh.sh
