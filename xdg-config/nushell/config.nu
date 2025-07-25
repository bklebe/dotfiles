# config.nu
#
# Installed by:
# version = "0.105.1"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.
use std/util "path add"
source nix.nu
use mise.nu

$env.config.show_banner = false

def path_helper [dir] {
    ls $dir | select name | each { |f| open $f.name | split row "\n" } | flatten
}

$env.HOMEBREW_PREFIX = "/opt/homebrew"
$env.HOMEBREW_CELLAR = $"($env.HOMEBREW_PREFIX)/Cellar"
$env.HOMEBREW_REPOSITORY = "/opt/homebrew"
$env.path ++= path_helper /etc/paths.d/
path add $"($env.HOMEBREW_PREFIX)/bin" $"($env.HOMEBREW_PREFIX)/sbin"

$env.MANPATH = $"($env.MANPATH?):(path_helper /etc/manpaths.d/ | str join ":")"
if ($env.MANPATH | str starts-with ":" | not $in) {
    $env.MANPATH = $":($env.MANPATH)"
}

let editor = ["zed", "--wait", "--new"]
$env.INFOPATH = $"($env.HOMEBREW_PREFIX)/share/info:($env.INFOPATH?)"
$env.config.buffer_editor = $editor
$env.GRADLE_USER_HOME = $env.XDG_DATA_HOME | path join "gradle"
$env.EDITOR = $editor | str join " "
