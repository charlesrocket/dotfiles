use path
use str
use math

set E:LC_ALL = "en_US.UTF-8"

each {|pth|
  if (not (path:is-dir &follow-symlink $pth)) {
    echo (styled "WARNING: '"$pth"' in $paths no longer exists!" red)
  }
} $paths

# eval (starship init elvish)
