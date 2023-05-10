use path
use str
use math

set E:LC_ALL = "en_US.UTF-8"

set paths = [
  ~/bin
  ~/.cargo/bin
  ~/.emacs.d/bin
  /usr/local/bin
  /usr/local/sbin
  /usr/bin
  /usr/sbin
  /bin
  /sbin
]

each {|pth|
  if (not (path:is-dir &follow-symlink $pth)) {
    echo (styled "WARNING: '"$pth"' in $paths no longer exists!" red)
  }
} $paths

# eval (starship init elvish)
