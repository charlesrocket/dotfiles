PATH=$PATH:~/.local/bin:~/.cargo/bin:~/.emacs.d/bin

export PATH
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CONFIG_DIRS="/usr/local/etc/xdg:/etc/xdg"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_DESKTOP_DIR="$HOME/Desktop"
export XDG_DOCUMENTS_DIR="$HOME/Documents"
export XDG_DOWNLOAD_DIR="$HOME/Downloads"
export XDG_MUSIC_DIR="$HOME/Music"
export XDG_PICTURES_DIR="$HOME/Pictures"
export XDG_VIDEOS_DIR="$HOME/Videos"
export XDG_TEMPLATES_DIR="$HOME/Templates"
export XDG_PUBLICSHARE_DIR="$HOME/Public"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_DATA_DIRS="/usr/local/share:/usr/share"
export RUST_BACKTRACE=1
export DIRENV_WARN_TIMEOUT=1m
# {> if SYSTEM.os == freebsd <}
#export GDK_DEBUG=no-portals
# {> endif <}

# {> if SYSTEM.os == macos <}
export PATH="/usr/local/opt/avr-gcc@8/bin:$PATH"
export PATH="/usr/local/opt/arm-gcc-bin@8/bin:$PATH"
# {> endif <}

# shellcheck source=/dev/null
test -f "$HOME"/.exitrc && trap '. $HOME/.exitrc' EXIT
