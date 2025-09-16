# config.nu
#
# Installed by:
# version = '0.105.1'
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

# PROFILE: Startup timing
let $startup_begin = (date now)

use std/util 'path add'
let $after_imports = (date now)
if ($env.NU_PROFILE? | default "" | is-not-empty) {
    print $"PROFILE: Imports took (($after_imports - $startup_begin) / 1ms)ms"
}
source nix.nu
let $after_nix = (date now)
if ($env.NU_PROFILE? | default "" | is-not-empty) {
    print $"PROFILE: nix.nu took (($after_nix - $after_imports) / 1ms)ms"
}

$env.config.show_banner = false

def path_helper [dir] {
    ls $dir | select name | each { |f| open $f.name | split row '\n' } | flatten
}

$env.HOMEBREW_PREFIX = '/opt/homebrew'
$env.HOMEBREW_CELLAR = $'($env.HOMEBREW_PREFIX)/Cellar'
$env.HOMEBREW_REPOSITORY = '/opt/homebrew'
$env.path ++= path_helper /etc/paths.d/
path add $'($env.HOMEBREW_PREFIX)/bin' $'($env.HOMEBREW_PREFIX)/sbin'
path add $'($env.HOME)/Library/Application Support/JetBrains/Toolbox/scripts'
path add $'($env.XDG_DATA_HOME)/cargo/bin'
path add $'($env.HOME)/.local/bin'
path add '/usr/local/bin'
let $after_path_setup = (date now)
if ($env.NU_PROFILE? | default "" | is-not-empty) {
    print $"PROFILE: Path setup took (($after_path_setup - $after_nix) / 1ms)ms"
}

$env.MANPATH = $'($env.MANPATH?):(path_helper /etc/manpaths.d/ | str join ':')'
if ($env.MANPATH | str starts-with ':' | not $in) {
    $env.MANPATH = $':($env.MANPATH)'
}

$env.INFOPATH = $'($env.HOMEBREW_PREFIX)/share/info:($env.INFOPATH?)'
$env.config.buffer_editor = $env.EDITOR

$env.PAGER = 'less -FRX'
let $after_env_setup = (date now)
if ($env.NU_PROFILE? | default "" | is-not-empty) {
    print $"PROFILE: Environment setup took (($after_env_setup - $after_path_setup) / 1ms)ms"
}

let carapace_completer = {|spans|
    carapace $spans.0 nushell ...$spans | from json
}

$env.config.completions.external = {
    enable: true
    max_results: 100
    completer: $carapace_completer
}

# source secrets.nu
let $after_secrets = (date now)
if ($env.NU_PROFILE? | default "" | is-not-empty) {
    print $"PROFILE: secrets.nu took (($after_secrets - $after_env_setup) / 1ms)ms"
    # print $"PROFILE: Total startup took (($after_secrets - $startup_begin) / 1ms)ms"
}
