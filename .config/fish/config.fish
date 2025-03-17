eval "$(/opt/homebrew/bin/brew shellenv)"

set -gx XDG_CONFIG_HOME "$HOME/.config"
set -gx XDG_DATA_HOME "$HOME/.local/share"
set -gx XDG_STATE_HOME "$HOME/.local/state"
set -gx XDG_CACHE_HOME "$HOME/.cache"
set -gx DOCKER_CONFIG "$XDG_CONFIG_HOME/docker"
set XDG_RUNTIME_DIR "$HOME/Library/Caches/TemporaryItems"
mkdir -p $XDG_RUNTIME_DIR
set -gx XDG_RUNTIME_DIR
set -gx GRADLE_USER_HOME "$XDG_DATA_HOME"/gradle

fish_add_path "$HOME/Library/Application Support/JetBrains/Toolbox/scripts"
fish_add_path "$HOME/Library/Application Support/Coursier/bin"

if status is-interactive
    # Commands to run in interactive sessions can go here
end
