use path
use str
use math
use direnv

set E:LC_ALL = "en_US.UTF-8"

var optpaths = [
  ~/bin
  ~/.cargo/bin
  ~/.emacs.d/bin
]

var optpaths-filtered = [(each { |p|
  if (path:is-dir $p) { put $p }
} $optpaths)]

set paths = [
  $@optpaths-filtered
  /usr/local/bin
  /usr/local/sbin
  /usr/bin
  /usr/sbin
  /bin
  /sbin
]

each { |pth|
  if (not (path:is-dir &follow-symlink $pth)) {
    echo (styled "WARNING: '"$pth"' in $paths no longer exists!" red)
  }
} $paths

if (not-eq "xterm" (get-env TERM)) {
  eval (starship init elvish)
}
