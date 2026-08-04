if $env.TERM != "xterm" {
  mkdir ($nu.data-dir | path join "vendor/autoload")
  starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
}

$env.config.buffer_editor = "ee"
$env.config.show_banner = false
$env.config.hooks.env_change.PWD = ($env.config.hooks.env_change.PWD?| default [] | append {||
    if (which direnv | is-empty) {
        return
    }

    direnv export json | from json | default {} | load-env
})
